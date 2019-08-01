FROM php:7-alpine
MAINTAINER pch18.cn

#安装GD库
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

#安装主程序
RUN rm -rf /var/www/html /data \
  && mkdir -p /var/www \
  && wget -O /tmp/master.zip "https://github.com/pch18-fork/KodExplorer/archive/master.zip" \
  && unzip /tmp/master.zip -d /var/www \ 
  && rm -rf /tmp/* \
  && mv /var/www/KodExplorer-master /var/www/html \
  && echo "<?php define('DATA_PATH','/data/');" > /var/www/html/config/define.php \
  && chmod -R 777 /var/www/html \
  && mv /var/www/html/data /data 

EXPOSE 80

CMD [ "php", "-S", "0.0.0.0:80", "-t", "/var/www/html" ]
