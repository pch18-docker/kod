FROM alpine
MAINTAINER pch18.cn

COPY entrypoint.sh /entrypoint.sh

#安装PHP
RUN apk add php \
    php-session php-iconv php-curl php-mbstring php-gd php-exif
    
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
