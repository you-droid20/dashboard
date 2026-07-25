# --- Build/runtime image ---
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Prevent .pyc files and enable stdout/stderr flushing (good for container logs)
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Install dependencies first (better layer caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Run as a non-root user
RUN useradd -m appuser
USER appuser

EXPOSE 5000

# Basic container healthcheck (Harness/K8s can also use its own probes)
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')" || exit 1

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "app:app"]
