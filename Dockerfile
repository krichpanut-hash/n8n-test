# ✅ ใช้ base image ที่เบาและเสถียร
FROM python:3.11-slim

# ตั้ง working directory ภายใน container
WORKDIR /app

# คัดลอกไฟล์ทั้งหมดจากโปรเจกต์เข้า container
COPY . .

# ✅ อัปเดตระบบและติดตั้ง tools ที่จำเป็น (เช่น gcc สำหรับ build lib)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# ✅ ติดตั้ง dependencies ทั้งหมดจาก requirements.txt ถ้ามี
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# ✅ ติดตั้ง settrade-v2 (เพิ่มตรงนี้ถ้ายังไม่อยู่ใน requirements.txt)
RUN pip install --no-cache-dir settrade-v2

# ✅ กำหนดคำสั่งเริ่มรันแอป (แก้ตามชื่อไฟล์จริง)
# ตัวอย่าง: main.py หรือ app.py
CMD ["python", "main.py"]
