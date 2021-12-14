import './db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class GlobalDb extends Db {
  static GlobalDb? _cache;
  factory GlobalDb() {
    if (_cache == null) {
      _cache = GlobalDb._internal();
    }
    return _cache!;
  }

  GlobalDb._internal();

  @override
  Future<Database> createAndOpenDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'app.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db
          .execute('CREATE TABLE Setting (key TEXT PRIMARY KEY, value TEXT)');
      await db.execute('CREATE TABLE Cache (key TEXT PRIMARY KEY, value TEXT)');
    });
  }
}
