# Базовый образ с Python
FROM python:3.12-slim

# Рабочая директория внутри контейнера
WORKDIR /app

# Копируем зависимости
COPY requirements.txt /app/

# Устанавливаем Python-библиотеки
RUN pip install --no-cache-dir --require-hashes -r requirements.txt \
 && python -m pip check

# Копируем исходники
COPY . /app

# Открываем порт 8080
EXPOSE 8080

# Команда запуска
CMD ["gunicorn", "-b", "0.0.0.0:8080", "app:app"]
