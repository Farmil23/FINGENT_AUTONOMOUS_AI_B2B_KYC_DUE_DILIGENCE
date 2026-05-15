FROM python:3.10-slim

WORKDIR /app

# Install dependencies first (layer cache)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source
COPY . .

# Create uploads directory
RUN mkdir -p uploads

EXPOSE 7860

# PORT env var injected by HuggingFace Spaces (7860) or Railway/Render (8000)
CMD ["sh", "-c", "uvicorn app.api.v1.endpoints:app --host 0.0.0.0 --port ${PORT:-7860} --workers 1"]
