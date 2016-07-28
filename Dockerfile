FROM php:apache

ENV ARCHIVE develop.tar.gz
RUN mkdir /var/www/html/cacti
WORKDIR /var/www/html/cacti
ADD https://github.com/twhtanghk/cacti/archive/${ARCHIVE} /tmp
RUN tar --strip-components=1 -xzf /tmp/${ARCHIVE} && \
	rm /tmp/${ARCHIVE} && \
        cp php.ini /usr/local/etc/php/ && \
	apt-get update && \
	apt-get install -y rrdtool mariadb-client snmp libsnmp-dev libldap-dev libfreetype6-dev libjpeg-dev libpng12-dev libgmp-dev && \
	apt-get clean && \
	chown -R www-data.www-data . && \
	ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h && \
	docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
	docker-php-ext-install pdo pdo_mysql sockets snmp gd gmp ldap
EXPOSE 80
