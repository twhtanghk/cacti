#!/bin/sh

chown -R cactiuser.www-data /var/www/html/cacti/rra
service cron start
apache2-foreground
