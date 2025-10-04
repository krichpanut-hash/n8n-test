# ใช้ n8n เวอร์ชั่นที่ต้องการเป็น base image
FROM n8nio/n8n:latest

# สลับไปใช้ user root ชั่วคราวเพื่อติดตั้ง dependency
USER root

# ติดตั้งไลบรารี settrade-v2 ได้เลย
# ใช้ --break-system-packages เพื่อยืนยันการติดตั้งใน system's python environment
# ซึ่งยอมรับได้ใน context ของ Docker ที่มีการแยกสภาพแวดล้อมชัดเจน
RUN pip3 install --break-system-packages settrade-v2

# สลับกลับไปใช้ user node ตามเดิมเพื่อความปลอดภัย
USER node