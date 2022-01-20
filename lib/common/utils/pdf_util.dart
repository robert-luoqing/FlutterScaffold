import '../../config.dart';

class SPPdfUtil {
  static SPPdfUtil? _cache;
  factory SPPdfUtil() {
    _cache ??= SPPdfUtil._internal();
    return _cache!;
  }

  SPPdfUtil._internal();

  String getFullPdfUrl(String? pdfUrl) {
    if (pdfUrl == null || pdfUrl.trim() == "") {
      return "";
    }

    var lowerImageUrl = pdfUrl.toLowerCase();
    if (lowerImageUrl.startsWith("http://") ||
        lowerImageUrl.startsWith("https://")) {
      return pdfUrl;
    } else {
      if (pdfUrl.startsWith("/")) {
        return Config.netPdfHost + pdfUrl.substring(1);
      } else {
        return Config.netPdfHost + pdfUrl;
      }
    }
  }
}
