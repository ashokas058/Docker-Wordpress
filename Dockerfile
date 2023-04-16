FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
RUN  apt update && \ 
apt-get install -y software-properties-common && \ 
echo "ENTER" | add-apt-repository ppa:ondrej/php && \ 
apt update && \ 
apt-get install -y php8.2 php8.2-cli php8.2-common php8.2-opcache php8.2-mysql php8.2-mbstring php8.2-xml php8.2-gd php8.2-curl php8.2-zip
RUN apt-get install -y nginx-full
RUN apt-get install -y php8.2-fpm
RUN apt-get install -y vim
RUN find /etc/nginx/ -name default -type f -delete
RUN rm -rf /var/www/html
COPY app /var/www/web-apps/
RUN chown -R www-data:www-data /var/www/web-apps/
COPY app-config/nqueens.in.conf /etc/nginx/conf.d/
RUN rm /etc/nginx/nginx.conf 
COPY app-config/nginx.conf /etc/nginx/
COPY app-config/start-script.sh /var/www/scripts/
WORKDIR /var/www/scripts/
RUN chmod +x start-script.sh
CMD [ "sh", "start-script.sh" ]
