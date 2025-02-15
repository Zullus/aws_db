# Instalar pacotes necessários (se não estiverem instalados)
# install.packages(c("RMySQL", "DBI"))

# Carrega bibliotecas
library(RMySQL)
library(DBI)

# Configurações de conexão
con <- dbConnect(MySQL(), 
                 host = "db",
                 user = "root",
                 password = "root",
                 dbname = "aws_db")

# Query de seleção
query <- "SELECT id, teste, createad_at FROM teste"

# Executa a query
resultado <- dbGetQuery(con, query)

# Loop através dos resultados
for(i in 1:nrow(resultado)) {
  cat(sprintf(" %d  %s  %s\n", 
              resultado$id[i],
              ifelse(is.na(resultado$teste[i]), "NULL", resultado$teste[i]),
              ifelse(is.na(resultado$createad_at[i]), "NULL", resultado$createad_at[i]))
  )
}

# Fecha a conexão
dbDisconnect(con)