#!/bin/bash

# UrERP Docker Quick Start Script
# Usage: ./start.sh [simple|full|stop|reset]

set -e

COMPOSE_FILE="docker-compose.simple.yml"
SITE_NAME="urerp.localhost"
DB_PASSWORD="UrERP2025Secure"
ADMIN_PASSWORD="admin"

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}"
echo "================================================"
echo "       UrERP - Docker Deployment"
echo "       Multi-Country HRMS Solution"
echo "================================================"
echo -e "${NC}"

case "$1" in
    simple|"")
        echo -e "${GREEN}Starting UrERP with pre-built images...${NC}"
        docker compose -f docker-compose.simple.yml up -d

        echo ""
        echo -e "${BLUE}Waiting for services to start...${NC}"
        sleep 10

        # Check if site exists
        if ! docker exec urerp-backend ls sites/$SITE_NAME 2>/dev/null; then
            echo -e "${GREEN}Creating new site...${NC}"

            # Wait for PostgreSQL
            echo "Waiting for PostgreSQL..."
            until docker exec urerp-db pg_isready -U urerp 2>/dev/null; do
                sleep 2
            done

            # Create site
            docker exec -it urerp-backend bench new-site $SITE_NAME \
                --db-type postgres \
                --db-host postgres \
                --db-port 5432 \
                --db-name urerp_db \
                --db-user urerp \
                --db-password $DB_PASSWORD \
                --admin-password $ADMIN_PASSWORD \
                --no-mariadb-socket

            # Install apps
            echo -e "${GREEN}Installing ERPNext...${NC}"
            docker exec -it urerp-backend bench --site $SITE_NAME install-app erpnext

            echo -e "${GREEN}Installing HRMS...${NC}"
            docker exec -it urerp-backend bench --site $SITE_NAME install-app hrms

            # Set as default site
            docker exec urerp-backend bash -c "echo '$SITE_NAME' > sites/currentsite.txt"
        fi

        echo ""
        echo -e "${GREEN}================================================${NC}"
        echo -e "${GREEN}  UrERP is ready!${NC}"
        echo -e "${GREEN}================================================${NC}"
        echo ""
        echo "  URL:      http://localhost:8081"
        echo "  Login:    Administrator"
        echo "  Password: $ADMIN_PASSWORD"
        echo ""
        echo "Commands:"
        echo "  ./start.sh stop   - Stop all services"
        echo "  ./start.sh reset  - Reset and start fresh"
        echo ""

        # Open browser
        if command -v open &> /dev/null; then
            open http://localhost:8081
        fi
        ;;

    full)
        echo -e "${GREEN}Building and starting UrERP (custom build)...${NC}"
        docker compose up -d --build
        echo ""
        echo "URL: http://localhost:8000"
        ;;

    stop)
        echo -e "${BLUE}Stopping UrERP...${NC}"
        docker compose -f docker-compose.simple.yml down
        docker compose down 2>/dev/null || true
        echo -e "${GREEN}Stopped.${NC}"
        ;;

    reset)
        echo -e "${RED}Resetting UrERP (all data will be lost)...${NC}"
        read -p "Are you sure? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            docker compose -f docker-compose.simple.yml down -v
            docker compose down -v 2>/dev/null || true
            echo -e "${GREEN}Reset complete. Run ./start.sh to start fresh.${NC}"
        fi
        ;;

    logs)
        docker compose -f docker-compose.simple.yml logs -f
        ;;

    *)
        echo "Usage: ./start.sh [simple|full|stop|reset|logs]"
        echo ""
        echo "  simple  - Start with pre-built images (default)"
        echo "  full    - Build custom image and start"
        echo "  stop    - Stop all services"
        echo "  reset   - Remove all data and start fresh"
        echo "  logs    - View container logs"
        ;;
esac
