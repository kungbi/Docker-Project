#!/bin/sh

if [ ! -d /run/mysqld ]; then
	echo "Setting up MariaDB..."
	mkdir -p /opt/mariadb/data
	chown -R mysql:mysql /opt/mariadb/data

	echo "Initializing MariaDB..."
	mariadb-install-db --user=mysql --datadir=/opt/mariadb/data

	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld

	echo "Creating init.sql..."
	/tmp/init_sql.sh

	echo "Configuring MariaDB..."
	exec mariadbd --user=mysql --init-file=/tmp/init.sql --datadir=/opt/mariadb/data 

else
	exec mariadbd --user=mysql --datadir=/opt/mariadb/data
fi
