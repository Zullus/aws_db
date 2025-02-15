import java.sql.Connection
import java.sql.DriverManager
import java.sql.ResultSet

fun main() {
    val url = "jdbc:mysql://127.0.0.1:3306/aws_db"
    val user = "root"
    val password = "root"

    try {
        // Certifique-se que o JAR do driver está no mesmo diretório ou no classpath
        Class.forName("com.mysql.cj.jdbc.Driver") // Driver correto para MySQL 8+
        val connection: Connection = DriverManager.getConnection(url, user, password)

        val statement = connection.createStatement()
        val resultSet: ResultSet = statement.executeQuery("SELECT id, teste, createad_at FROM teste")

        while (resultSet.next()) {
            val id = resultSet.getInt("id")
            val teste = resultSet.getString("teste")
            val createdAt = resultSet.getTimestamp("createad_at")
            println(" $id $teste $createdAt")
        }

        resultSet.close()
        statement.close()
        connection.close()
    } catch (e: Exception) {
        println("Erro ao conectar ao banco de dados: ${e.message}")
    }
}