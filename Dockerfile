FROM n8nio/n8n:latest

# เปลี่ยนเป็น root user เพื่อติดตั้ง packages
USER root

# ติดตั้ง Python และ pip
RUN apk add --no-cache python3 py3-pip

# ติดตั้ง Python packages ที่ต้องการ
RUN pip3 install settrade-v2

# กลับไปใช้ user n8n
USER n8n

# ตั้งค่า environment variables
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=password