#!/bin/sh

sed s/127.0.0.1/0.0.0.0/ /etc/php83/php-fpm.d/www.conf -i

if [ ! -d /wordpress ]; then
	curl -O https://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz
	mv wordpress/* /var/www/html

	# WordPress 설치 및 DB 초기화
	wp config create \
		--dbname="${MARIADB_DATABASE}" \
		--dbuser="${MARIADB_USER}" \
		--dbpass="${MARIADB_PASSWORD}" \
		--dbhost="${MARIADB_HOST}" \
		--path="/var/www/html" \
		--allow-root

	echo "Initializing WordPress..."
	wp core install \
		--url="${WP_DOMAIN_NAME}" \
		--title="${WP_TITLE}" \
		--admin_user="${WP_ADMIN_USER}" \
		--admin_password="${WP_ADMIN_PASSWORD}" \
		--admin_email="${WP_ADMIN_EMAIL}" \
		--path="/var/www/html" \
		--allow-root

	# 일반 사용자 생성
	echo "Creating a regular user..."
	wp user create ${WP_USER} ${WP_EMAIL} \
		--role=${WP_ROLE} \
		--user_pass="${WP_PASSWORD}" \
		--path="/var/www/html" \
		--allow-root


fi

/usr/sbin/php-fpm83 -F -R