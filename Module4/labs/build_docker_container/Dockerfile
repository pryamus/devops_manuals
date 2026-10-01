# Используем официальные образ из Docker Hub
FROM python:3.14-slim

# Устанавливаем рабочую директорию в контейнере
WORKDIR = /app

# Копируем файлы проекта в контейнер source_path dest_path 
COPY . .

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt --index-url https://pypi-mirror.gitverse.ru/simple/

# Открываем порт
EXPOSE 5000

# Запускаем приложение
CMD ["python3", "app.py"]

