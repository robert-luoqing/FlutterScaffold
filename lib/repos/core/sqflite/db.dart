import 'package:sqflite/sqflite.dart';

abstract class Db {
  Database? _database;

  Future _openDatabase() async {
    if (this._database == null) {
      this._database = await this.createAndOpenDatabase();
    }
  }

  Future<Database> createAndOpenDatabase();

  Future<int> insert(String table, Map<String, Object?> values,
      {String? nullColumnHack, ConflictAlgorithm? conflictAlgorithm}) async {
    await _openDatabase();
    return await this._database!.insert(table, values,
        nullColumnHack: nullColumnHack, conflictAlgorithm: conflictAlgorithm);
  }

  Future<int> udpate(String table, Map<String, Object?> values,
      {String? where,
      List<Object?>? whereArgs,
      ConflictAlgorithm? conflictAlgorithm}) async {
    await _openDatabase();
    return await this._database!.update(table, values,
        where: where,
        whereArgs: whereArgs,
        conflictAlgorithm: conflictAlgorithm);
  }

  Future<int> delete(String table,
      {String? where, List<Object?>? whereArgs}) async {
    await _openDatabase();
    return await this
        ._database!
        .delete(table, where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, Object?>>> query(String table,
      {bool? distinct,
      List<String>? columns,
      String? where,
      List<Object?>? whereArgs,
      String? groupBy,
      String? having,
      String? orderBy,
      int? limit,
      int? offset}) async {
    await _openDatabase();
    return await this._database!.query(table,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset);
  }

  Future<int> rawInsert(String sql, [List<Object?>? arguments]) async {
    await _openDatabase();
    return await this._database!.rawInsert(sql, arguments);
  }

  Future<int> rawUpdate(String sql, [List<Object?>? arguments]) async {
    await _openDatabase();
    return await this._database!.rawUpdate(sql, arguments);
  }

  Future<int> rawDelete(String sql, [List<Object?>? arguments]) async {
    await _openDatabase();
    return await this._database!.rawDelete(sql, arguments);
  }

  Future<List<Map<String, Object?>>> rawQuery(String sql,
      [List<Object?>? arguments]) async {
    await _openDatabase();
    return await this._database!.rawQuery(sql, arguments);
  }
}
