import 'dart:io';

import 'base/base_dao.dart';

class FileDao extends BaseDao {
  static FileDao? _cache;
  factory FileDao() {
    _cache ??= FileDao._internal();
    return _cache!;
  }
  FileDao._internal();

  Future<String> uploadImage(File file) async {
    var url = await upload("/api/v1.community/upload", file: file);
    return url;
  }

  Future<String> uploadVoice(File file) async {
    var url = await upload("/api/v1.community/upload", file: file);
    return url;
  }
}
