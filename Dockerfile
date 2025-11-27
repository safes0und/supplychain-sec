# Базовый образ с Python
FROM python:3.12-slim
LABEL org.opencontainers.image.description="python demo app"

# Создание non-root пользователя
RUN useradd --create-home --shell /bin/bash appuser

# Рабочая директория внутри контейнера
WORKDIR /app

# Копируем зависимости
COPY requirements.txt /app/

# Устанавливаем Python-библиотеки
RUN pip install --no-cache-dir --require-hashes -r requirements.txt \
 && python -m pip check

# Копируем исходники
COPY . /app

# Меняем владельца файлов и переключаемся на non-root пользователя
RUN chown -R appuser:appuser /app
USER appuser

# Открываем порт 7777
EXPOSE 7777

# Команда запуска
CMD ["gunicorn", "-b", "0.0.0.0:7777", "app:app"]
