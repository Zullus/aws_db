// Arquivo: lib/main.dart
import 'package:mysql1/mysql1.dart';

void main() async {
  // Configurações de conexão
  final settings = ConnectionSettings(
    host: '127.0.0.1',
    port: 3306,
    user: 'root',
    password: 'root',
    db: 'aws_db'
  );

  try {
    // Estabelece a conexão
    final conn = await MySqlConnection.connect(settings);
    print('Conexão estabelecida com sucesso!');

    // Executa a query
    var results = await conn.query('SELECT * FROM teste');

    //Verifica se trouxe dados
    if (results.isEmpty) {
      print('Nenhum registro encontrado! Pode ser um bug da biblioteca mysql1');
    }
    // Itera sobre os resultados
    for (var row in results) {
      print('${row['id']} ${row['teste']} ${row['createad_at']}');
    }

    // Fecha a conexão
    await conn.close();
    
  } catch (e) {
    print('Erro: $e');
  }
}