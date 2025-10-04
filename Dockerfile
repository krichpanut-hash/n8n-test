# 1. Start from the official n8n image
FROM n8nio/n8n:latest

# 2. Switch to root user to install packages
USER root

# 3. Install Python and pip (runtime dependencies)
RUN apk add --no-cache python3 py3-pip

# 4. Install build tools as a temporary package. THIS IS THE FIX.
#    - build-base: Contains compilers like gcc.
#    - python3-dev: Contains header files for compiling Python extensions.
RUN apk add --no-cache --virtual .build-deps build-base python3-dev

# 5. Copy your requirements file
COPY requirements.txt .

# 6. Now, run pip install. It will use the build tools we just installed.
RUN pip install --no-cache-dir -r requirements.txt

# 7. Clean up by removing the temporary build tools to keep the final image small
RUN apk del .build-deps

# 8. Switch back to the non-root 'node' user for security
USER node