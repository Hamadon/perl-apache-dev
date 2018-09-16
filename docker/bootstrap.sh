#!/bin/bash

# Setup php
sed -ri \
  -e "s/^upload_max_filesize.*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/" \
  -e "s/^post_max_size.*/post_max_size = ${PHP_POST_MAX_SIZE}/" \
  -e "s/^memory_limit.*/memory_limit = ${PHP_MEMORY_LIMIT}/" \
  -e "s/^display_errors.*/display_errors = On/" \
  -e "s/^display_startup_errors.*/display_startup_errors = On/" \
  /etc/php/7.2/apache2/php.ini
	
# Setup Apache's vhosts
sed -ri \
  -e "s|%DOCROOT%|${PROJECT_DOCROOT}|" \
  -e "s|%WEBROOT%|${PROJECT_WEBROOT}|" \
  /etc/apache2/sites-available/000-default.conf

sed -ri \
  -e "s|%DOCROOT%|${PROJECT_DOCROOT}|" \
  -e "s|%WEBROOT%|${PROJECT_WEBROOT}|" \
  /etc/apache2/sites-available/default-ssl.conf

exec supervisord -n
