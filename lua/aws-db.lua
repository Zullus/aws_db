-- Importa o módulo MySQL
require "luasql.mysql"

-- Inicializa o ambiente MySQL
local mysql = require("luasql.mysql")
local env = mysql.mysql()

-- Configurações de conexão
local config = {
    host = "localhost",
    user = "root",
    password = "root",
    database = "aws_db"
}

-- Função principal
local function main()
    -- Tenta conectar ao banco de dados
    local conn = env:connect(
        config.database,
        config.user,
        config.password,
        config.host
    )

    if not conn then
        print("Erro ao conectar ao banco de dados")
        return
    end

    -- Define a query
    local query = "SELECT id, teste, created_at FROM tabela_teste"
    
    -- Executa a query
    local cursor = conn:execute(query)
    
    if not cursor then
        print("Erro ao executar a query")
        conn:close()
        return
    end

    -- Imprime o cabeçalho
    print("\nResultados:")
    print("----------------------------------------")

    -- Loop através dos resultados
    local row = cursor:fetch({}, "a")  -- "a" para retornar como array associativo
    while row do
        -- Trata valores nulos
        local id = row.id or "NULL"
        local teste = row.teste or "NULL"
        local created_at = row.created_at or "NULL"
        
        -- Imprime a linha
        print(string.format(
            "ID: %s | Teste: %s | Created At: %s",
            id, teste, created_at
        ))
        
        -- Próxima linha
        row = cursor:fetch({}, "a")
    end

    -- Fecha as conexões
    cursor:close()
    conn:close()
    env:close()
end

-- Executa o programa principal com tratamento de erros
local status, err = pcall(main)
if not status then
    print("Erro na execução:", err)
end