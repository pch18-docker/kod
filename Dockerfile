FROM php:7-alpine
MAINTAINER pch18.cn

RUN rm -rf /var/www/html /data \
  && mkdir -p /var/www \
  && wget -O /tmp/master.zip "https://github.com/pch18-fork/KodExplorer/archive/master.zip" \
  && unzip /tmp/master.zip -d /var/www \ 
  && rm -rf /tmp/* \
  && mv /var/www/KodExplorer-master /var/www/html \
  && chmod -R 777 /var/www/html \
  && mv /var/www/html/data /data \
  && echo "<?php define('DATA_PATH','/data');" > /var/www/html/config/define.php

EXPOSE 80

CMD [ "php", "-S", "0.0.0.0:80", "-t", "/var/www/html" ]
