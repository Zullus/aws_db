# Imagem base do R
FROM r-base:latest

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    libmariadb-dev \
    libssl-dev \
    libcurl4-openssl-dev

# Instalar pacotes R necessários
RUN R -e "install.packages(c('RMySQL', 'DBI'), repos='http://cran.rstudio.com/')"

# Definir diretório de trabalho
WORKDIR /app

# Copiar o script R
COPY aws-db.R .

# Comando para executar o script
CMD ["Rscript", "aws-db.R"]