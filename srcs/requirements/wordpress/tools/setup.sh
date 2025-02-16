#!/bin/sh

sed -i s/127.0.0.1/wordpress/ /etc/php83/php-fpm.d/www.conf

mkdir -p /var/www/html/wordpress
cd /var/www/html/wordpress

if [ ! -f wp-config.php ]; then
	sed -i s/memory_limit\ =\ 128M/memory_limit\ =\ 512M/ /etc/php83/php.ini
	wp core download --allow-root

	# WordPress 설치 및 DB 초기화
	wp config create \
		--dbname="${MARIADB_DATABASE}" \
		--dbuser="${MARIADB_USER}" \
		--dbpass="${MARIADB_PASSWORD}" \
		--dbhost="${MARIADB_HOST}" \
		--allow-root

	echo "Initializing WordPress..."
	wp core install \
		--url="${WP_DOMAIN_NAME}" \
		--title="${WP_TITLE}" \
		--admin_user="${WP_ADMIN_USER}" \
		--admin_password="${WP_ADMIN_PASSWORD}" \
		--admin_email="${WP_ADMIN_EMAIL}" \
		--allow-root

	# 일반 사용자 생성
	echo "Creating a regular user..."
	wp user create ${WP_USER} ${WP_EMAIL} \
		--role=${WP_ROLE} \
		--user_pass="${WP_PASSWORD}" \
		--allow-root
else
	echo "WordPress is already initialized. Skipping setup."
fi

/usr/sbin/php-fpm83 -F -R
