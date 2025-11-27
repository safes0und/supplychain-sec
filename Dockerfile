FROM python:3.12-slim

RUN useradd --create-home --shell /bin/bash appuser

WORKDIR /app

COPY requirements.txt /app/

RUN pip install --no-cache-dir --require-hashes -r requirements.txt \
 && python -m pip check

COPY . /app

RUN chown -R appuser:appuser /app
USER appuser

EXPOSE 7777

CMD ["gunicorn", "-b", "0.0.0.0:7777", "app:app"]
