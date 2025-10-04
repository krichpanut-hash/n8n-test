# 1. เริ่มต้นจาก n8n official image ตัวล่าสุด
FROM n8nio/n8n:latest

# 2. เปลี่ยนเป็น user 'root' ชั่วคราวเพื่อติดตั้งโปรแกรม
USER root

# 3. ติดตั้ง Python 3 และ pip
# n8n image ใช้ Alpine Linux ซึ่งใช้คำสั่ง 'apk' ในการติดตั้ง
RUN apk add --no-cache python3 py3-pip

# 4. คัดลอกไฟล์ requirements.txt เข้าไปใน image
COPY requirements.txt .

# 5. สั่งให้ pip ติดตั้ง library ทั้งหมดที่อยู่ใน requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# 6. (สำคัญมาก) เปลี่ยนกลับไปเป็น user 'node' เพื่อความปลอดภัยตามมาตรฐานของ n8n
USER node
