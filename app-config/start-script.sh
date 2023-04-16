set -e
service php8.2-fpm start
nginx -g 'daemon off;'
nginx -t
nginx -s reload