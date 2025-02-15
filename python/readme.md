# Acesso ao banco de dados em Pyton

## criar imagem Docker

`docker build -t aws-db-py .` 

## Para executar a aplicação Python no Docker

**Importante**: veja o nome correto da rede que o Docker Compose criou

`docker run -it --network docker_awsdb aws-db-py`