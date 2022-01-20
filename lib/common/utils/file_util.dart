import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

class SPFileUtil {
  static SPFileUtil? _cache;
  factory SPFileUtil() {
    _cache ??= SPFileUtil._internal();
    return _cache!;
  }

  SPFileUtil._internal();

  Future<void> saveByteFileWithByteData(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<void> saveByteFileWithUint8List(Uint8List data, String path) async {
    // await Directory(path).create(recursive: true);
    var file = File(path);
    await file.create(recursive: true);
    await file.writeAsBytes(data);
  }

  Future<void> saveTextFile(String content, String path) async {
    File file = File(path);
    await file.writeAsString(content);
  }

  Future<String> readTextFile(String path) async {
    File file = File(path);
    String fileContent = await file.readAsString();
    return fileContent;
  }

  Future<bool> fileExists(String path) async {
    File file = File(path);
    return await file.exists();
  }

  bool fileExistsSync(String path) {
    File file = File(path);
    return file.existsSync();
  }

  Future<void> deleteFile(String path) async {
    File file = File(path);
    var exist = await file.exists();
    if (exist) {
      await file.delete();
    }
  }

  Future<void> deleteFolder(String dirPath) async {
    final dir = Directory(dirPath);
    if (dir.existsSync()) {
      dir.deleteSync(recursive: true);
    }
  }

  Future<void> copyFile(String fromPath, String targetPath) async {
    File file = File(fromPath);
    var exist = await file.exists();
    if (exist) {
      await file.copy(targetPath);
    }
  }

  void copyFileSync(String fromPath, String targetPath) {
    File file = File(fromPath);
    var exist = file.existsSync();
    if (exist) {
      file.copySync(targetPath);
    }
  }

  int getFolderSizeSync(String dirPath) {
    // int fileNum = 0;
    int totalSize = 0;
    var dir = Directory(dirPath);
    try {
      if (dir.existsSync()) {
        dir
            .listSync(recursive: true, followLinks: false)
            .forEach((FileSystemEntity entity) {
          if (entity is File) {
            // fileNum++;
            totalSize += entity.lengthSync();
          }
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return totalSize;
  }

  String formatFileSize(int? size) {
    if (size == null) {
      return "0K";
    } else if (size < 1000) {
      return size.toString() + "B";
    } else if (size < 1000 * 1000) {
      return ((size * 100 / 1000).round() / 100.0).toString() + "K";
    } else {
      return ((size * 100 / 1000000).round() / 100.0).toString() + "M";
    }
  }
}
