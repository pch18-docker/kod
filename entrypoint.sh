set -e

dir=`ls /data`
if [ "$dir" == "" ]; then
  echo 'copy /web/data to /data'
  cp -r /web/data/* /data/
fi

nginx
php-fpm7 -F
