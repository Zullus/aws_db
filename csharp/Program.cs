using MySqlConnector;
using System;

namespace csharp
{
    class Program
    {
        static void Main(string[] args)
        {
            var connectionString = "server=127.0.0.1;user=root;password=root;database=aws_db";
            using var connection = new MySqlConnection(connectionString);
            connection.Open();

            var query = "SELECT * FROM teste";
            using var cmd = new MySqlCommand(query, connection);
            using var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                Console.WriteLine($" {reader.GetInt32(0)} {reader.GetString(1)} {reader.GetDateTime(2)}");
            }            
        }
    }
}