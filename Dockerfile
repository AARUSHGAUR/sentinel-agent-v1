FROM python:3.12-slim
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
WORKDIR /app
COPY sentinel-v1-secure-local.zip /tmp/sentinel-v1-secure-local.zip.b64
RUN python -c "import base64,io,zipfile; z=zipfile.ZipFile(io.BytesIO(base64.b64decode(open('/tmp/sentinel-v1-secure-local.zip.b64','rb').read()))); z.extractall('/app')" \
 && pip install --no-cache-dir -r /app/requirements.txt \
 && groupadd --system sentinel && useradd --system --gid sentinel --home-dir /app sentinel \
 && mkdir -p /app/data /app/reports && chown -R sentinel:sentinel /app
USER sentinel
EXPOSE 8000
CMD ["sh", "-c", "uvicorn agent.dashboard:app --host 0.0.0.0 --port ${PORT:-8000}"]