const std = @import("std");
const c = @cImport({
    @cInclude("mysql/mysql.h");
});

fn getCString(ptr: ?[*]u8) []const u8 {
    if (ptr) |p| {
        var len: usize = 0;
        while (p[len] != 0) : (len += 1) {}
        return p[0..len];
    }
    return "NULL";
}

pub fn main() !void {
    // Inicializa o allocator
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    // Inicializa a conexão MySQL
    const mysql = c.mysql_init(null);
    if (mysql == null) {
        std.debug.print("Erro ao inicializar MySQL\n", .{});
        return error.MySQLInitFailed;
    }
    defer c.mysql_close(mysql);

    // Conecta ao banco de dados
    if (c.mysql_real_connect(
        mysql,
        "127.0.0.1",     // host
        "root",         // usuario
        "root",     // senha
        "aws_db",     // nome do banco
        3306,           // porta
        null,           // unix_socket
        0               // flags
    ) == null) {
        const err_msg = c.mysql_error(mysql);
        std.debug.print("Erro na conexão: {s}\n", .{err_msg});
        return error.MySQLConnectionFailed;
    }

    // Executa a query
    const query = "SELECT id, teste, createad_at FROM teste";
    if (c.mysql_query(mysql, query) != 0) {
        const err_msg = c.mysql_error(mysql);
        std.debug.print("Erro na query: {s}\n", .{err_msg});
        return error.MySQLQueryFailed;
    }

    // Obtém o resultado
    const result = c.mysql_store_result(mysql);
    if (result == null) {
        const err_msg = c.mysql_error(mysql);
        std.debug.print("Erro ao obter resultado: {s}\n", .{err_msg});
        return error.MySQLResultFailed;
    }
    defer c.mysql_free_result(result);

    // Imprime os resultados
    var row: ?[*]?[*]u8 = null;

    //std.debug.print("\nResultados:\n", .{});
    //std.debug.print("----------------------------------------\n", .{});
    
    while (true) {
        row = c.mysql_fetch_row(result);
        if (row == null) break;
        
        const safe_row = row.?;
        
        // Converte os valores para strings seguras usando nossa função auxiliar
        const id = getCString(if (safe_row[0] != null) safe_row[0].? else null);
        const teste = getCString(if (safe_row[1] != null) safe_row[1].? else null);
        const createad_at = getCString(if (safe_row[2] != null) safe_row[2].? else null);
        
        std.debug.print(" {s}  {s} {s}\n", .{
            id, teste, createad_at,
        });
    }
}