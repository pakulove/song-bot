FROM python:3.12-slim

WORKDIR /app

RUN pip install setuptools==68.2.2

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "main.py"]
