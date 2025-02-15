defmodule Awsdb do
  def run do
    # Configurações de conexão
    opts = [
      hostname: "127.0.0.1",
      username: "root",
      password: "root",
      database: "aws_db"
    ]

    # Estabelece a conexão
    {:ok, conn} = MyXQL.start_link(opts)

    # Executa a query
    {:ok, results} = MyXQL.query(conn, "SELECT * FROM teste")

    # Imprime os resultados
    Enum.each(results.rows, fn row ->
      [id, teste, createad_at] = row
      IO.puts "#{id} #{teste} #{createad_at}"
    end)

    # Fecha a conexão
    GenServer.stop(conn)
  end
end