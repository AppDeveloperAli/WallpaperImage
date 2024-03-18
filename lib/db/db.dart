import 'package:path/path.dart';

import '../exports.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();

    return _database!;
  }

  // AppVersion = 1.0.9, DBVersion = 9
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'image_switch_pro.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute('''
        CREATE TABLE selected_index(id INTEGER PRIMARY KEY, index_value INTEGER)
  ''');

    await db.rawInsert('''
    INSERT INTO selected_index (id, index_value)
    VALUES (?,?)
  ''', [1, 0]);
  }

  Future<int> getSelectedIndex() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps =
        await db.query('selected_index', where: 'id = ?', whereArgs: [1]);

    if (maps.isNotEmpty) {
      return maps.first['index_value'] as int;
    } else {
      // If no entry, you might want to handle this case appropriately
      return 0;
    }
  }

  Future<void> updateSelectedIndex(int newIndex) async {
    Database db = await instance.database;

    await db.update(
      'selected_index',
      {'index_value': newIndex},
      where: 'id = ?',
      whereArgs: [1],
    );
  }
}
