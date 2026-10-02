# Используем официальные образ из Docker Hub
FROM python:3.14-slim

# Устанавливаем рабочую директорию в контейнере
WORKDIR /app

# Копируем requirements.txt (зависимости) для кэширования слоев
COPY requiremenst.txt

# Устанавливаем зависимости
# RUN pip install --no-cache-dir -r requirements.txt --index-url https://pypi-mirror.gitverse.ru/simple/
RUN --mount=type=cache,target=/root/.cache/pip pip install -r requirements.txt --index-url https://pypi-mirror.gitverse.ru/simple/

# Копируем файлы проекта в контейнер source_path dest_path 
COPY app.py .

# Открываем порт
EXPOSE 5000

# Запускаем приложение
CMD ["python3", "app.py"]

