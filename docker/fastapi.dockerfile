FROM python:3.13.0-slim

# Install system dependencies for pdf2image and poppler
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libpoppler-cpp-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libopenjp2-7-dev \
    tesseract-ocr \
    poppler-utils \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

WORKDIR /app-fastapi

COPY ./fastapi/requirements.txt ./requirements.txt

RUN pip install -r requirements.txt

COPY ./fastapi .

EXPOSE 7000

CMD ["python", "main.py"]
