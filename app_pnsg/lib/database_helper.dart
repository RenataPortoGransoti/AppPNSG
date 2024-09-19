import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'events.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE events(
            id TEXT PRIMARY KEY, 
            nome_evento TEXT, 
            data_inicio TEXT, 
            data_fim TEXT, 
            local TEXT, 
            descricao TEXT
          )
          ''',
        );
      },
      version: 1,
    );
  }

  Future<void> saveEvent(Map<String, dynamic> event) async {
    final db = await database;
    print('Salvando evento: $event'); // Log de depuração

    // Verificação para garantir que o evento tenha um ID válido
    if (event['id'] == null || event['id'].isEmpty) {
      throw Exception('O evento precisa de um ID válido para ser salvo.');
    }

    // Salvando o evento
    await db.insert(
      'events',
      event,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<Map<String, dynamic>>> getEvents() async {
    final db = await database;
    final events = await db.query('events');
    print('Eventos carregados do banco: $events'); // Log de depuração
    return events;
  }

  Future<void> deleteEvent(String id) async {
    final db = await database;
    await db.delete('events', where: 'id = ?', whereArgs: [id]);
  }
}