FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PLAYWRIGHT_BROWSERS_PATH=/ms-playwright

WORKDIR /app

# Install minimal system dependencies for Playwright Firefox
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    fonts-liberation \
    fonts-unifont \
    libgdk-pixbuf-2.0-0 \
    libgtk-3-0 \
    libxss1 \
    libxrandr2 \
    libasound2 \
    libpangocairo-1.0-0 \
    libatk1.0-0 \
    libcairo-gobject2 \
  && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/requirements.txt

# Install Python deps (includes playwright) and browsers (firefox) without system deps
RUN pip install --upgrade pip \
 && pip install -r requirements.txt \
 && python -m playwright install firefox

# Copy project files
COPY . /app

# Ensure runtime directories exist (will usually be mounted as volumes)
RUN mkdir -p /app/config /app/share /app/downloads

CMD ["python", "quark.py"]


