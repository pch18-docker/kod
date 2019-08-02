FROM alpine
MAINTAINER pch18.cn

COPY entrypoint.sh /entrypoint.sh
COPY nginx_default.conf /etc/nginx/conf.d/default.conf

#安装PHP NGINX
RUN apk add php php-fpm nginx \
    php-session php-iconv php-curl php-mbstring php-gd php-exif \
    && mkdir /run/nginx \
    && touch /run/nginx/nginx.pid
    
    
#安装主程序
RUN wget -O /tmp/master.zip "https://github.com/pch18-fork/KodExplorer/archive/master.zip" \
  && unzip /tmp/master.zip -d /tmp \ 
  && mv /tmp/KodExplorer-master /web \
  && rm -rf /tmp/* \
  && echo "<?php define('DATA_PATH','/data/');" > /web/config/define.php \
  && chmod -R 777 /web /entrypoint.sh
  
VOLUME /web
EXPOSE 80
CMD /entrypoint.sh
