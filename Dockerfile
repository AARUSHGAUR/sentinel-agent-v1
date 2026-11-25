FROM python:3.12-slim
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
WORKDIR /app
COPY sentinel-v1-secure-local.zip /tmp/sentinel-v1-secure-local.zip
RUN python -c "import zipfile; zipfile.ZipFile('/tmp/sentinel-v1-secure-local.zip').extractall('/app')" \
 && pip install --no-cache-dir -r /app/requirements.txt \
 && groupadd --system sentinel && useradd --system --gid sentinel --home-dir /app sentinel \
 && mkdir -p /app/data /app/reports && chown -R sentinel:sentinel /app
USER sentinel
EXPOSE 8000
CMD ["sh", "-c", "uvicorn agent.dashboard:app --host 0.0.0.0 --port ${PORT:-8000}"]