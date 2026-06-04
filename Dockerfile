FROM python:3.8-slim-bullseye

ENV PYTHONDONTWRITEBYTECODE=1 \
	PYTHONUNBUFFERED=1 \
	DEBIAN_FRONTEND=noninteractive

WORKDIR /app

# Install system dependencies securely in one layer and clean apt cache
COPY requirements.txt .
RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y --no-install-recommends gcc libpq-dev ca-certificates \
	&& rm -rf /var/lib/apt/lists/* \
	&& pip install --upgrade pip setuptools wheel \
	&& pip install --no-cache-dir -r requirements.txt

# Copy app
COPY . /app/

# Use a non-root user for better security
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser \
	&& chown -R appuser:appgroup /app

USER appuser

EXPOSE 8000

# Run migrations at container start (avoid doing them at build time)
CMD ["sh", "-c", "python manage.py makemigrations --noinput && python manage.py migrate --noinput && python manage.py runserver 0.0.0.0:8000"]