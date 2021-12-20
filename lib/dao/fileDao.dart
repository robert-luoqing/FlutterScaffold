import 'dart:io';

import 'base/baseDao.dart';

class FileDao extends BaseDao {
  static FileDao? _cache;
  factory FileDao() {
    if (_cache == null) {
      _cache = FileDao._internal();
    }
    return _cache!;
  }
  FileDao._internal();

  Future<String> uploadImage(File file) async {
    var url = await this.upload("/api/v1.community/upload", file: file);
    return url;
  }

  Future<String> uploadVoice(File file) async {
    var url = await this.upload("/api/v1.community/upload", file: file);
    return url;
  }
}
