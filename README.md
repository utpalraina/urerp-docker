# UrERP Docker

Ready-to-use Docker setup for UrERP (Frappe/ERPNext v15) with PostgreSQL backend.

## Quick Start

### Option 1: Using Pre-built Images (Fastest)

```bash
# Start all services
docker compose -f docker-compose.simple.yml up -d

# Wait for services to start (about 1-2 minutes)
docker logs -f urerp-backend

# Create site (first time only)
docker exec -it urerp-backend bench new-site urerp.localhost \
    --db-type postgres \
    --db-host postgres \
    --db-port 5432 \
    --db-name urerp_db \
    --db-user urerp \
    --db-password UrERP2025Secure \
    --admin-password admin \
    --no-mariadb-socket

# Install apps
docker exec -it urerp-backend bench --site urerp.localhost install-app erpnext
docker exec -it urerp-backend bench --site urerp.localhost install-app hrms

# Access UrERP
open http://localhost:8081
```

### Option 2: Building Custom Image

```bash
# Build and start
docker compose up -d --build

# Access UrERP (after initialization)
open http://localhost:8000
```

## Services

| Service | Port | Description |
|---------|------|-------------|
| Web UI | 8081 | UrERP web interface |
| PostgreSQL | 5433 | Database |
| Redis Cache | - | Caching |
| Redis Queue | - | Background jobs |

## Default Credentials

| User | Password |
|------|----------|
| Administrator | admin |
| PostgreSQL (urerp) | UrERP2025Secure |

## Configuration

Edit `.env` file to customize:

```env
DB_PASSWORD=UrERP2025Secure
ADMIN_PASSWORD=admin
SITE_NAME=urerp.localhost
```

## Commands

```bash
# View logs
docker compose logs -f

# Stop services
docker compose down

# Stop and remove volumes (reset)
docker compose down -v

# Access bench console
docker exec -it urerp-backend bench --site urerp.localhost console

# Run migrations
docker exec -it urerp-backend bench --site urerp.localhost migrate

# Backup
docker exec -it urerp-backend bench --site urerp.localhost backup
```

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                     Docker Network                       │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐              │
│  │ Frontend │  │ Backend  │  │ Socket.io│              │
│  │  :8080   │  │  :8000   │  │  :9000   │              │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘              │
│       │             │             │                     │
│       └─────────────┼─────────────┘                     │
│                     │                                   │
│  ┌──────────┐  ┌────┴─────┐  ┌──────────┐              │
│  │ Scheduler│  │PostgreSQL│  │  Redis   │              │
│  │          │  │  :5432   │  │ (cache/  │              │
│  └──────────┘  └──────────┘  │  queue)  │              │
│                              └──────────┘              │
│  ┌──────────┐  ┌──────────┐                            │
│  │ Worker   │  │ Worker   │                            │
│  │ (short)  │  │ (long)   │                            │
│  └──────────┘  └──────────┘                            │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

## Included Apps

- **Frappe** v15 - Framework
- **ERPNext** v15 - ERP modules
- **HRMS** v15 - Human Resource Management
- **custom_hr_multi** - Multi-Country HRMS extensions

## Custom HR Modules

- Travel Management (Per Diem, Approval Matrix)
- Shift & Overtime Management
- Loan Adjustments
- Multi-Country Compliance (India, UAE, Bhutan, Korea, USA, Canada)
- Factory Compliance Reports

## Volumes

| Volume | Purpose |
|--------|---------|
| postgres-data | Database files |
| sites | Frappe sites configuration |
| logs | Application logs |

## Troubleshooting

### Site not accessible
```bash
# Check if site exists
docker exec -it urerp-backend ls sites/

# Recreate site
docker exec -it urerp-backend bench new-site urerp.localhost --force ...
```

### Database connection error
```bash
# Check PostgreSQL status
docker exec -it urerp-db psql -U urerp -d urerp_db -c "SELECT 1"
```

### Reset everything
```bash
docker compose down -v
docker compose up -d
# Then recreate site
```

## Production Deployment

For production, consider:
1. Use proper SSL/TLS certificates
2. Set strong passwords in `.env`
3. Enable backups
4. Use external managed PostgreSQL
5. Configure proper resource limits

---

**UrERP** - Enterprise Resource Planning with Multi-Country HRMS
