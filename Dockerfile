# 使用官方的 PHP-FPM 镜像作为基础镜像
FROM hub.docker.mereith.com/library/php:8.1-fpm

# 安装 Nginx 并删除缓存
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# 将 Nginx 配置文件复制到容器中
COPY nginx.conf /etc/nginx/nginx.conf

# 将应用程序代码复制到容器中
COPY . /var/www/html

# 设置工作目录
WORKDIR /var/www/html

RUN chmod -R 777 /var/www/html

# 暴露 80 端口
EXPOSE 80

# 启动 Nginx 和 PHP-FPM
CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]
