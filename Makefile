SRCS_DIR=./srcs
ENV_FILE=${SRCS_DIR}/.env
DATA_DIR=${SRCS_DIR}/data

all: 
	docker compose --env-file ${ENV_FILE} -f ./srcs/docker-compose.yaml up -d --build

clean:
	docker compose -f ./srcs/docker-compose.yaml down

fclean: 
	docker compose -f ./srcs/docker-compose.yaml down --volumes --rmi all

re: fclean all