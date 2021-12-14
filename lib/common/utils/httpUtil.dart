import 'dart:async';
import '../../../common/utils/fileUtil.dart';
import 'package:http/http.dart' as http2;

class SPHttpUtil {
  static SPHttpUtil? _cache;
  factory SPHttpUtil() {
    if (_cache == null) {
      _cache = SPHttpUtil._internal();
    }
    return _cache!;
  }

  SPHttpUtil._internal();

  Future<void> downloadImage(
      String imageUrl, String localPathAndFileName) async {
    final http2.Response r = await http2.get(
      Uri.parse(imageUrl),
    );

    final data = r.bodyBytes;
    await SPFileUtil().saveByteFileWithUint8List(data, localPathAndFileName);
  }

  Future<void> downloadFile(String fileUrl, String localPathAndFileName) async {
    final http2.Response r = await http2.get(
      Uri.parse(fileUrl),
    );

    final data = r.bodyBytes;
    await SPFileUtil().saveByteFileWithUint8List(data, localPathAndFileName);
  }
}
