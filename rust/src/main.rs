use std::result::Result;
use mysql::*;
use mysql::prelude::*;

// Definindo a estrutura que vai receber os dados
#[derive(Debug)]
struct TestRow {
    id: i32,
    teste: Option<String>,
    createad_at: Option<String>,
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    // Configurações de conexão
    let url = "mysql://root:root@127.0.0.1:3306/aws_db";
    
    // Estabelece a conexão
    let pool = Pool::new(url)?;
    let mut conn = pool.get_conn()?;
    
    // Query para selecionar os dados
    let query = "SELECT id, teste, createad_at FROM teste";
    
    // Executa a query e mapeia os resultados para nossa estrutura
    let results = conn.query_map(
        query,
        |(id, teste, createad_at)| TestRow {
            id,
            teste,
            createad_at,
        },
    )?;

    // Imprime o cabeçalho
    // println!("\nResultados:");
    // println!("----------------------------------------");

    // Loop através dos resultados
    for row in results {
        println!(
            "{} {} {}", 
            row.id,
            row.teste.as_deref().unwrap_or("NULL"),
            row.createad_at.as_deref().unwrap_or("NULL")
        );
    }

    Ok(())
}