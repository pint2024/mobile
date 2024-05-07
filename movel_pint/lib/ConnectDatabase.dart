import 'package:postgres/postgres.dart';

class DatabaseManager {
  late PostgreSQLConnection _connection;

  Future<void> connectToDatabase() async {
    final connection = PostgreSQLConnection(
      'dpg-cnge0pq1hbls73fq15vg-a.frankfurt-postgres.render.com',
      5432,
      'manager',
      password: '2Tes25NellX6Es9MM92Mg1a5g59Jz5J3',
      useSSL: true, 
    );

    await connection.open();
    _connection = connection;
  }

  Future<void> createTables() async {
  await _connection.query('''
    CREATE TABLE IF NOT EXISTS atividade (
      id SERIAL PRIMARY KEY,
      nome TEXT,
      campo_id INTEGER,
      categoria_id INTEGER,
      classificacao_id INTEGER,
      descricao TEXT,
      comentario_id INTEGER,
      data TEXT,
      hora TEXT,
      FOREIGN KEY (campo_id) REFERENCES campo(id),
      FOREIGN KEY (categoria_id) REFERENCES categoria(id),
      FOREIGN KEY (classificacao_id) REFERENCES classificacao(id),
      FOREIGN KEY (comentario_id) REFERENCES comentario(id)
    )
  ''');

  await _connection.query('''
    CREATE TABLE IF NOT EXISTS campo (
      id SERIAL PRIMARY KEY,
      nome TEXT,
      descricao TEXT
    )
  ''');

  await _connection.query('''
    CREATE TABLE IF NOT EXISTS categoria (
      id SERIAL PRIMARY KEY,
      nome TEXT,
      descricao TEXT
    )
  ''');

  await _connection.query('''
    CREATE TABLE IF NOT EXISTS classificacao (
      id SERIAL PRIMARY KEY,
      nome TEXT,
      descricao TEXT
    )
  ''');

  await _connection.query('''
    CREATE TABLE IF NOT EXISTS comentario (
      id SERIAL PRIMARY KEY,
      atividade_id INTEGER,
      usuario_id INTEGER,
      texto TEXT,
      data TEXT,
      FOREIGN KEY (atividade_id) REFERENCES atividade(id),
      FOREIGN KEY (usuario_id) REFERENCES utilizador(id)
    )
  ''');

  await _connection.query('''
    CREATE TABLE IF NOT EXISTS conversa (
      id SERIAL PRIMARY KEY,
      usuario1_id INTEGER,
      usuario2_id INTEGER,
      FOREIGN KEY (usuario1_id) REFERENCES utilizador(id),
      FOREIGN KEY (usuario2_id) REFERENCES utilizador(id)
    )
  ''');

  await _connection.query('''
    CREATE TABLE IF NOT EXISTS denuncia (
      id SERIAL PRIMARY KEY,
      atividade_id INTEGER,
      usuario_id INTEGER,
      texto TEXT,
      data TEXT,
      FOREIGN KEY (atividade_id) REFERENCES atividade(id),
      FOREIGN KEY (usuario_id) REFERENCES utilizador(id)
    )
  ''');

  await _connection.query('''
    CREATE TABLE IF NOT EXISTS estado (
      id SERIAL PRIMARY KEY,
      nome TEXT,
      descricao TEXT
    )
  ''');

  await _connection.query('''
    CREATE TABLE IF NOT EXISTS formulario (
      id SERIAL PRIMARY KEY,
      nome TEXT,
      descricao TEXT
    )
  ''');

  await _connection.query('''
    CREATE TABLE IF NOT EXISTS gosto (
      id SERIAL PRIMARY KEY,
      atividade_id INTEGER,
      usuario_id INTEGER,
      FOREIGN KEY (atividade_id) REFERENCES atividade(id),
      FOREIGN KEY (usuario_id) REFERENCES utilizador(id)
    )
  ''');

  await _connection.query('''
    CREATE TABLE IF NOT EXISTS mensagem (
      id SERIAL PRIMARY KEY,
      conversa_id INTEGER,
      remetente_id INTEGER,
      destinatario_id INTEGER,
      texto TEXT,
      data TEXT,
      FOREIGN KEY (conversa_id) REFERENCES conversa(id),
      FOREIGN KEY (remetente_id) REFERENCES utilizador(id),
      FOREIGN KEY (destinatario_id) REFERENCES utilizador(id)
    )
  ''');

  await _connection.query('''
    CREATE TABLE IF NOT EXISTS notificacao (
      id SERIAL PRIMARY KEY,
      usuario_id INTEGER,
      mensagem TEXT,
      data TEXT,
      FOREIGN KEY (usuario_id) REFERENCES utilizador(id)
    )
  ''');

  await _connection.query('''
    CREATE TABLE IF NOT EXISTS participante (
      id SERIAL PRIMARY KEY,
      atividade_id INTEGER,
      usuario_id INTEGER,
      FOREIGN KEY (atividade_id) REFERENCES atividade(id),
      FOREIGN KEY (usuario_id) REFERENCES utilizador(id)
    )
  ''');

  await _connection.query('''
    CREATE TABLE IF NOT EXISTS perfil (
      id SERIAL PRIMARY KEY,
      usuario_id INTEGER,
      descricao TEXT,
      FOREIGN KEY (usuario_id) REFERENCES utilizador(id)
    )
  ''');

  await _connection.query('''
    CREATE TABLE IF NOT EXISTS registo (
      id SERIAL PRIMARY KEY,
      usuario_id INTEGER,
      data TEXT,
      FOREIGN KEY (usuario_id) REFERENCES utilizador(id)
    )
  ''');

  await _connection.query('''
    CREATE TABLE IF NOT EXISTS resposta (
      id SERIAL PRIMARY KEY,
      formulario_id INTEGER,
      pergunta_id INTEGER,
      texto TEXT,
      FOREIGN KEY (formulario_id) REFERENCES formulario(id)
    )
  ''');

  await _connection.query('''
    CREATE TABLE IF NOT EXISTS revisao (
      id SERIAL PRIMARY KEY,
      atividade_id INTEGER,
      usuario_id INTEGER,
      texto TEXT,
      data TEXT,
      FOREIGN KEY (atividade_id) REFERENCES atividade(id),
      FOREIGN KEY (usuario_id) REFERENCES utilizador(id)
    )
  ''');

  await _connection.query('''
    CREATE TABLE IF NOT EXISTS subcomentario (
      id SERIAL PRIMARY KEY,
      comentario_id INTEGER,
      usuario_id INTEGER,
      texto TEXT,
      data TEXT,
      FOREIGN KEY (comentario_id) REFERENCES comentario(id),
      FOREIGN KEY (usuario_id) REFERENCES utilizador(id)
    )
  ''');

  await _connection.query('''
    CREATE TABLE IF NOT EXISTS subtopico (
      id SERIAL PRIMARY KEY,
      topico_id INTEGER,
      nome TEXT,
      descricao TEXT,
      FOREIGN KEY (topico_id) REFERENCES topico(id)
    )
  ''');

  await _connection.query('''
    CREATE TABLE IF NOT EXISTS topico (
      id SERIAL PRIMARY KEY,
      nome TEXT,
      descricao TEXT
    )
  ''');

  await _connection.query('''
    CREATE TABLE IF NOT EXISTS utilizador (
      id SERIAL PRIMARY KEY,
      nome TEXT,
      email TEXT,
      senha TEXT
    )
  ''');

  print('Tabelas criadas com sucesso.');
}


  Future<void> closeConnection() async {
    await _connection.close();
  }
}

void main() async {
  final databaseManager = DatabaseManager();

  try {
    await databaseManager.connectToDatabase();
    await databaseManager.createTables();
  } catch (e) {
    print('Erro ao conectar ao banco de dados: $e');
  } finally {
    await databaseManager.closeConnection();
  }
}
