FROM python:3.12-slim

WORKDIR /app

# Copy dependencies and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy your FastAPI app source
COPY post.py .

# Create and switch to non-root user
RUN adduser --disabled-password --gecos "" appuser
USER appuser

# Expose the FastAPI port
EXPOSE 8000

# Start FastAPI with uvicorn
CMD ["uvicorn", "post:app", "--host", "0.0.0.0", "--port", "8000"]

