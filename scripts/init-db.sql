-- UrERP PostgreSQL Initialization Script
-- Creates required extensions and permissions

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- Grant permissions
GRANT ALL PRIVILEGES ON DATABASE urerp_db TO urerp;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO urerp;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO urerp;

-- Set default privileges for future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO urerp;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO urerp;
