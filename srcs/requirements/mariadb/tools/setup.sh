#!/bin/sh

if [ ! -d /run/mysqld ]; then
	echo "Setting up MariaDB..."
	mkdir -p /opt/mariadb/data
	chown -R mysql:mysql /opt/mariadb/data

	echo "Initializing MariaDB..."
	mariadb-install-db --user=mysql --datadir=/opt/mariadb/data

	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
	mariadbd --user=mysql --datadir=/opt/mariadb/data &
	export PID=$!

	echo "Waiting for MariaDB to initialize..."
	until mariadb -e "SELECT 1" > /dev/null 2>&1; do
		echo "MariaDB is initializing..."
		sleep 1
	done

	echo "Configuring MariaDB..."
	mariadb -e "CREATE USER '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';"
	mariadb -e "CREATE DATABASE ${MARIADB_DATABASE};"
	mariadb -e "GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%' WITH GRANT OPTION;"
	mariadb -e "FLUSH PRIVILEGES;"

	kill -9 $PID
fi

exec mariadbd --user=mysql --datadir=/opt/mariadb/data