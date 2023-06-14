import 'package:practical/model/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

   Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  DatabaseHelper.internal();

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'github_users.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('CREATE TABLE users (id INTEGER PRIMARY KEY, username TEXT, avatarUrl TEXT, note TEXT)');
    });
  }

  Future<void> saveUser(User user) async {
    final db = await database;
    await db?.insert('users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('users');
    return List.generate(maps.length, (index) {
      return User(
        id: maps[index]['id'],
        username: maps[index]['username'],
        avatarUrl: maps[index]['avatarUrl'],
        note: maps[index]['note'],
      );
    });
  }

  Future<void> updateNoteForUser(User user) async {
    final db = await database;
    await db?.update(
      'users',
      {'note': user.note},
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }
}