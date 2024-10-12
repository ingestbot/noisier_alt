FROM python:alpine

RUN adduser -D -H noisier
RUN mkdir /app && chown noisier:noisier /app
USER noisier
WORKDIR /app
HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD "ps uxww | grep -v grep | grep noisier" || exit 1

# RUN python -m venv /venv
RUN python -m venv /app/venv
# ENV PATH="/venv/bin:${PATH}"
ENV PATH="/app/venv/bin:${PATH}"

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# COPY . .
COPY noisier.py .
COPY config.json . 

# ENTRYPOINT [ "python", "/app/noisier.py", "--log", "debug", "--config", "/app/config.json"]
ENTRYPOINT [ "python", "/app/noisier.py", "--config", "/app/config.json"]

