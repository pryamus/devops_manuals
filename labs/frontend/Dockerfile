# Официальные образ Nginx
FROM nginx:alpine

# Копируем конфигурацию Nginx
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Копируем файлы web страниц
COPY public/ /usr/share/nginx/html/

# Слушаем порт 8080
EXPOSE 8080

# Выполняем запуск
CMD ["nginx", "-g", "deamon off;"]

