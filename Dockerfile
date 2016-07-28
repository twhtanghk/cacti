FROM php:apache

RUN mkdir /var/www/html/cacti
WORKDIR /var/www/html/cacti
ADD https://github.com/twhtanghk/cacti/archive/master.tar.gz /tmp
RUN tar --strip-components=1 -xzf /tmp/master.tar.gz && \
	rm /tmp/master.tar.gz && \
	apt-get update && \
	apt-get install -y rrdtool mariadb-client snmp libsnmp-dev && \
	apt-get clean && \
	docker-php-ext-install pdo pdo_mysql sockets snmp
COPY /var/www/html/cacti/php.ini /usr/local/etc/php/
VOLUME ["/usr/local/etc/php/php.ini", "/var/www/html/cacti/include/config.php"]
EXPOSE 80
