import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class SPDateUtil {
  static SPDateUtil? _cache;
  factory SPDateUtil() {
    if (_cache == null) {
      _cache = SPDateUtil._internal();
    }
    return _cache!;
  }

  SPDateUtil._internal();

  String toDateStrFromTimestamp(int timestamp) {
    return this.toDateStr(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

  /// 因为Api用的是yyyy-M-dd
  String toDateStrForAPI(DateTime dt) {
    return formatDate(dt, [yyyy, '-', mm, '-', dd]);
  }

  String toDateStr(DateTime dt) {
    return formatDate(dt, [yyyy, '-', mm, '-', dd]);
  }

  String toDateTimeStrFromTimestamp(int timestamp) {
    return this.toDateTimeStr(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

  String toDateTimeStr(DateTime dt) {
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

  String hoursToString(int hours, {int daysRemoveHours = 10}) {
    if (hours < 0) hours = 0;
    var remainHours = hours % 24;
    var remainDays = hours / 24;
    if (remainDays > 0) {
      if (remainDays > 10) {
        return "${remainDays.toString()}天";
      } else {
        if (remainHours != 0) {
          return "${remainDays.toString()}天${remainHours.toString()}小时";
        } else {
          return "${remainDays.toString()}天";
        }
      }
    } else {
      return "${remainHours.toString()}小时";
    }
  }

  DateTime? getDataFromDateStrForAPI(String? dt) {
    if (dt == null || dt.trim() == "") {
      return null;
    }

    // yyyy MM dd HH:mm:ss
    var format1 = new DateFormat("yyyy-MM-dd HH:mm:ss");
    try {
      return format1.parse(dt);
    } catch (e1, _) {
      try {
        var format2 = new DateFormat("yyyy-MM-dd");
        return format2.parse(dt);
      } catch (e2, _) {}
    }

    return null;
  }

  static DateTime dateTimeFromJson(int int) =>
      DateTime.fromMillisecondsSinceEpoch(int);
  static int dateTimeToJson(DateTime time) => time.millisecondsSinceEpoch;
}
