import 'package:date_format/date_format.dart';

class DateUtil {
  static DateUtil? _cache;
  factory DateUtil() {
    if (_cache == null) {
      _cache = DateUtil._internal();
    }
    return _cache!;
  }

  DateUtil._internal();

  String toDateStrFromTimestamp(int timestamp) {
    return this.toDateStr(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

  String toDateStr(DateTime dt) {
    return formatDate(dt, [yyyy, '/', mm, '/', dd]);
  }

  String toLongDateStrFromTimestamp(int timestamp) {
    return this.toLongDateStr(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

  String toLongDateStr(DateTime dt) {
    return formatDate(dt, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]);
  }

  String toTimeStrFromTimestamp(int timestamp) {
    return this.toTimeStr(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

  String toTimeStr(DateTime dt) {
    return formatDate(dt, [HH, ':', nn, ':', ss]);
  }

  String toShortTimeStrFromTimestamp(int timestamp) {
    return this.toShortTimeStr(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

  String toShortTimeStr(DateTime dt) {
    return formatDate(dt, [HH, ':', nn]);
  }
}
