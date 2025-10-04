# Dockerfile v4 - แก้ปัญหา externally-managed-environment
FROM n8nio/n8n:latest

USER root

# Install Python and basic runtime dependencies
RUN apk add --no-cache python3 py3-pip

# Install a wider range of build dependencies as a temporary virtual package
RUN apk add --no-cache --virtual .build-deps \
    build-base \
    python3-dev \
    gfortran \
    openblas-dev \
    lapack-dev \
    libffi-dev

COPY requirements.txt .

# THE FIX IS HERE: เพิ่ม flag --break-system-packages
RUN pip install --no-cache-dir --break-system-packages -r requirements.txt

# Clean up build dependencies
RUN apk del .build-deps

# กลับไปใช้ user n8n
USER n8n

# ตั้งค่า environment variables สำหรับ n8n
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=password
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678

# Expose port
EXPOSE 5678

# Command สำหรับรัน n8n
CMD ["n8n", "start"]