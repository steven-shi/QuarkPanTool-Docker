FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PLAYWRIGHT_BROWSERS_PATH=/ms-playwright

WORKDIR /app

# System deps for Playwright will be installed via `playwright install --with-deps`
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    fonts-liberation \
  && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/requirements.txt

# Install Python deps (includes playwright) and browsers (firefox) with required OS deps
RUN pip install --upgrade pip \
 && pip install -r requirements.txt \
 && python -m playwright install --with-deps firefox

# Copy project files
COPY . /app

# Ensure runtime directories exist (will usually be mounted as volumes)
RUN mkdir -p /app/config /app/share /app/downloads

CMD ["python", "quark.py"]


