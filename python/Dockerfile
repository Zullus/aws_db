# Base da imagem (utilize uma imagem base com Python pré-instalado)
FROM python:3.9-slim-buster

# Setar o diretório de trabalho dentro do container
WORKDIR /app

# Copiar o arquivo requirements.txt para o container
COPY requirements.txt requirements.txt

# Instalar as dependências
RUN pip install -r requirements.txt

# Copiar o código da aplicação para o container
COPY . .

# Comando para executar a aplicação
CMD ["python", "aws-db.py"]