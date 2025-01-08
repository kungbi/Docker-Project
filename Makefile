SRCS_DIR=./srcs
ENV_FILE=${SRCS_DIR}/.env
include ${ENV_FILE}

all: 
	mkdir -p ${MARIADB_PATH}
	mkdir -p ${WORDPRESS_PATH}
	chmod -R 777 ${DATA_PATH}
	docker compose --env-file ${ENV_FILE} -f ./srcs/docker-compose.yaml up -d --build

clean:
	docker compose -f ./srcs/docker-compose.yaml down

fclean: 
	docker compose -f ./srcs/docker-compose.yaml down --volumes --rmi all
	docker volume prune -f
	sudo rm -rf ${DATA_PATH}

re: fclean all

.PHONY: all clean fclean re