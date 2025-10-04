# Dockerfile v3 - เพิ่ม Dependencies สำหรับ Data Science packages
FROM n8nio/n8n:latest

USER root

# Install Python and basic runtime dependencies
RUN apk add --no-cache python3 py3-pip

# Install a wider range of build dependencies as a temporary virtual package
# ADDED: gfortran, openblas-dev, lapack-dev, libffi-dev (มักจำเป็นสำหรับ numpy, scipy)
RUN apk add --no-cache --virtual .build-deps \
    build-base \
    python3-dev \
    gfortran \
    openblas-dev \
    lapack-dev \
    libffi-dev

COPY requirements.txt .

# Run pip install
RUN pip install --no-cache-dir -r requirements.txt

# Clean up build dependencies
RUN apk del .build-deps

USER node