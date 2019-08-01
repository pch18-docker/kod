set -e

dir=`ls /data`
if [ "$dir" == "" ]; then
  echo 'copy /var/www/html/data to /data'
  cp -r /var/www/html/data/* /data/
fi

php -S 0.0.0.0:80 -t /var/www/html
