set -e

dir=`ls /data`
if [ "$dir" == "" ]; then
  echo 'copy /var/www/html/data to /data'
  cp -r /var/www/html/data/* /data/
fi

nginx
php-fpm7 -F
