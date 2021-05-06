import 'dart:io';
import 'dart:typed_data';

class FileUtil {
  static FileUtil? _cache;
  factory FileUtil() {
    if (_cache == null) {
      _cache = FileUtil._internal();
    }
    return _cache!;
  }

  FileUtil._internal();

  Future<void> writeByteDataToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
