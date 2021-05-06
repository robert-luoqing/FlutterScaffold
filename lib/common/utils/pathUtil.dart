import 'dart:io';

import 'package:path_provider/path_provider.dart' as pathProvider;

class PathUtil {
  static PathUtil? _cache;
  factory PathUtil() {
    if (_cache == null) {
      _cache = PathUtil._internal();
    }
    return _cache!;
  }

  PathUtil._internal();

  Future<String> getTemporaryDirectory() async {
    Directory tempDir = await pathProvider.getTemporaryDirectory();
    String tempPath = tempDir.path;
    return tempPath;
  }

  Future<String> getApplicationDocumentsDirectory() async {
    Directory tempDir = await pathProvider.getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    return tempPath;
  }
}
