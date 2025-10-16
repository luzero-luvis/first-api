# =============================
# 1️⃣ Builder Stage (installs deps)
# =============================
FROM python:3.12-slim AS builder

WORKDIR /app

# Copy dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

# =============================
# 2️⃣ Final Stage (runtime only)
# =============================
FROM python:3.12-alpine

WORKDIR /app

# Copy only installed packages (from builder)
COPY --from=builder /root/.local /root/.local

# Copy app source code
COPY . .

# Set PATH so installed packages are found
ENV PATH=/root/.local/bin:$PATH

# Use non-root user (security best practice)
RUN adduser -D appuser
USER appuser

EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

