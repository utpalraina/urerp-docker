# UrERP Docker Image
# Based on Frappe/ERPNext v15 with PostgreSQL support

FROM python:3.11-slim-bookworm

LABEL maintainer="Utpal Raina <utpal@urerp.com>"
LABEL description="UrERP - Enterprise Resource Planning with Multi-Country HRMS"
LABEL version="1.0.0"

# Build arguments
ARG FRAPPE_VERSION=version-15
ARG ERPNEXT_VERSION=version-15
ARG HRMS_VERSION=version-15
ARG NODE_VERSION=18

# Environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    FRAPPE_USER=frappe \
    BENCH_DIR=/home/frappe/frappe-bench

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Build essentials
    build-essential \
    git \
    curl \
    wget \
    # PostgreSQL client
    libpq-dev \
    postgresql-client \
    # MariaDB client (for bench compatibility)
    mariadb-client \
    libmariadb-dev \
    # Python dependencies
    python3-dev \
    python3-setuptools \
    python3-pip \
    # wkhtmltopdf dependencies
    fontconfig \
    libfontconfig1 \
    libfreetype6 \
    libjpeg62-turbo \
    libpng16-16 \
    libx11-6 \
    libxcb1 \
    libxext6 \
    libxrender1 \
    xfonts-75dpi \
    xfonts-base \
    # Other utilities
    supervisor \
    nginx \
    redis-tools \
    cron \
    sudo \
    locales \
    && rm -rf /var/lib/apt/lists/*

# Set locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g yarn

# Install wkhtmltopdf
RUN wget -q https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-3/wkhtmltox_0.12.6.1-3.bookworm_amd64.deb \
    && dpkg -i wkhtmltox_0.12.6.1-3.bookworm_amd64.deb || apt-get install -f -y \
    && rm wkhtmltox_0.12.6.1-3.bookworm_amd64.deb

# Create frappe user
RUN useradd -ms /bin/bash ${FRAPPE_USER} \
    && echo "${FRAPPE_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to frappe user
USER ${FRAPPE_USER}
WORKDIR /home/${FRAPPE_USER}

# Install bench
RUN pip install --user frappe-bench

# Add local bin to PATH
ENV PATH="/home/${FRAPPE_USER}/.local/bin:${PATH}"

# Initialize bench with Frappe
RUN bench init ${BENCH_DIR} \
    --frappe-branch ${FRAPPE_VERSION} \
    --skip-redis-config-generation \
    --verbose

WORKDIR ${BENCH_DIR}

# Get ERPNext
RUN bench get-app erpnext --branch ${ERPNEXT_VERSION}

# Get HRMS
RUN bench get-app hrms --branch ${HRMS_VERSION}

# Install psycopg2 for PostgreSQL
RUN pip install --user psycopg2-binary

# Copy custom app
COPY --chown=${FRAPPE_USER}:${FRAPPE_USER} apps/custom_hr_multi ${BENCH_DIR}/apps/custom_hr_multi

# Copy configuration files
COPY --chown=${FRAPPE_USER}:${FRAPPE_USER} config/common_site_config.json ${BENCH_DIR}/sites/common_site_config.json

# Copy initialization script
COPY --chown=${FRAPPE_USER}:${FRAPPE_USER} scripts/entrypoint.sh /entrypoint.sh
RUN sudo chmod +x /entrypoint.sh

# Expose ports
EXPOSE 8000 9000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8000/api/method/frappe.ping || exit 1

# Entrypoint
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bench", "start"]
