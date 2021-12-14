import '../../config.dart';

class SPImageUtil {
  static SPImageUtil? _cache;
  factory SPImageUtil() {
    if (_cache == null) {
      _cache = SPImageUtil._internal();
    }
    return _cache!;
  }

  SPImageUtil._internal();

  String getFullImageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.trim() == "") {
      return "";
    }

    var lowerImageUrl = imageUrl.toLowerCase();
    if (lowerImageUrl.startsWith("http://") ||
        lowerImageUrl.startsWith("https://")) {
      return imageUrl;
    } else {
      if (imageUrl.startsWith("/")) {
        return Config.netImageHost + imageUrl.substring(1);
      } else {
        return Config.netImageHost + imageUrl;
      }
    }
  }
}
