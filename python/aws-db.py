import mysql.connector

# Substitua pelos seus dados de conexão
mydb = mysql.connector.connect(
    host="db", # Seu host MySQL - usar o nome do serviço do docker-compose.yml
    user="root", # Seu usuário MySQL
    password="root", # Sua senha MySQL
    database="aws_db" # Nome do seu banco de dados
    )

mycursor = mydb.cursor()

mycursor.execute("SELECT * FROM teste")

myresult = mycursor.fetchall()

for x in myresult:
  print(x)

mydb.close()