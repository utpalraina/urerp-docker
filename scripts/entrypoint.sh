#!/bin/bash
set -e

# UrERP Docker Entrypoint Script
# Handles site creation, app installation, and startup

SITE_NAME="${SITE_NAME:-urerp.localhost}"
ADMIN_PASSWORD="${ADMIN_PASSWORD:-admin}"
DB_HOST="${DB_HOST:-postgres}"
DB_PORT="${DB_PORT:-5432}"
DB_NAME="${DB_NAME:-urerp_db}"
DB_USER="${DB_USER:-urerp}"
DB_PASSWORD="${DB_PASSWORD:-UrERP2025Secure}"
INSTALL_APPS="${INSTALL_APPS:-erpnext,hrms}"

echo "================================================"
echo "  UrERP - Enterprise Resource Planning"
echo "  Multi-Country HRMS Solution"
echo "================================================"

cd /home/frappe/frappe-bench

# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL..."
until PGPASSWORD=$DB_PASSWORD psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c '\q' 2>/dev/null; do
    echo "PostgreSQL is unavailable - sleeping"
    sleep 2
done
echo "PostgreSQL is ready!"

# Wait for Redis
echo "Waiting for Redis..."
until redis-cli -h redis-cache ping 2>/dev/null | grep -q PONG; do
    echo "Redis is unavailable - sleeping"
    sleep 2
done
echo "Redis is ready!"

# Check if site exists
if [ ! -d "sites/$SITE_NAME" ]; then
    echo "Creating new site: $SITE_NAME"

    # Create site with PostgreSQL
    bench new-site "$SITE_NAME" \
        --db-type postgres \
        --db-host "$DB_HOST" \
        --db-port "$DB_PORT" \
        --db-name "$DB_NAME" \
        --db-user "$DB_USER" \
        --db-password "$DB_PASSWORD" \
        --admin-password "$ADMIN_PASSWORD" \
        --no-mariadb-socket \
        --verbose

    # Install apps
    echo "Installing apps: $INSTALL_APPS"
    IFS=',' read -ra APPS <<< "$INSTALL_APPS"
    for app in "${APPS[@]}"; do
        app=$(echo "$app" | xargs)  # Trim whitespace
        if [ -d "apps/$app" ]; then
            echo "Installing $app..."
            bench --site "$SITE_NAME" install-app "$app" || echo "Warning: Failed to install $app"
        else
            echo "Warning: App $app not found in apps directory"
        fi
    done

    # Set as default site
    bench use "$SITE_NAME"

    # Enable developer mode (optional)
    bench --site "$SITE_NAME" set-config developer_mode 1

    # Run migrations
    echo "Running migrations..."
    bench --site "$SITE_NAME" migrate

    # Clear cache
    bench --site "$SITE_NAME" clear-cache

    echo "Site setup complete!"
else
    echo "Site $SITE_NAME already exists"

    # Run migrations for existing site
    echo "Running migrations..."
    bench --site "$SITE_NAME" migrate || true

    # Clear cache
    bench --site "$SITE_NAME" clear-cache || true
fi

# Set site as default
echo "$SITE_NAME" > sites/currentsite.txt

echo "================================================"
echo "  UrERP is ready!"
echo "  URL: http://localhost:8000"
echo "  Admin: Administrator / $ADMIN_PASSWORD"
echo "================================================"

# Execute command
exec "$@"
