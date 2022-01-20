import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as p;

class SPPathUtil {
  static SPPathUtil? _cache;
  factory SPPathUtil() {
    _cache ??= SPPathUtil._internal();
    return _cache!;
  }

  SPPathUtil._internal();

  Future<String> getTemporaryDirectory() async {
    Directory tempDir = await path_provider.getTemporaryDirectory();
    String tempPath = tempDir.path;
    return tempPath;
  }

  Future<String> getApplicationDocumentsDirectory() async {
    Directory tempDir = await path_provider.getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    return tempPath;
  }

  // if file is a.png, the extension name is .png
  String getFileExtension(String fileName) {
    return p.extension(fileName);
  }

  String getFileNameFromPath(String path) {
    return p.basename(path);
  }

  Future<String> getPathInDocumentDirectory(String path) async {
    return p.join(await getApplicationDocumentsDirectory(), path);
  }

  Future<String> getPathInTemporaryDirectory(String path) async {
    return p.join(await getTemporaryDirectory(), path);
  }
}
