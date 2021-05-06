import './db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDb extends Db {
  static final Map<String, UserDb> _cache = <String, UserDb>{};
  factory UserDb(String userId) {
    _cache.putIfAbsent(userId, () => UserDb._internal(userId));
    return _cache[userId]!;
  }

  final String userId;
  UserDb._internal(this.userId);

  @override
  Future<Database> createAndOpenDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'user_$userId.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // Avoid using below
      // "add","all","alter","and","as","autoincrement","between","case","check",
      // "collate","commit","constraint","create","default","deferrable","delete",
      // "distinct","drop","else","escape","except","exists","foreign","from","group",
      // "having","if","in","index","insert","intersect","into","is","isnull","join",
      // "limit","not","notnull","null","on","or","order","primary","references",
      // "select","set","table","then","to","transaction","union","unique","update",
      // "using","values","when","where"
      await db
          .execute('CREATE TABLE Setting (key TEXT PRIMARY KEY, value TEXT)');
    });
  }
}
