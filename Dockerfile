FROM python:alpine
RUN python -m venv /venv
ENV PATH="/venv/bin:${PATH}"
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt --user
WORKDIR /app
COPY . .
ENTRYPOINT [ "python", "/app/noisier.py", "--config", "/app/config.json"]
