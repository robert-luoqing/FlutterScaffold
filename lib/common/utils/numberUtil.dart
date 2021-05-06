import 'package:intl/intl.dart';

class NumberUtil {
  static NumberUtil? _cache;
  factory NumberUtil() {
    if (_cache == null) {
      _cache = NumberUtil._internal();
    }
    return _cache!;
  }

  NumberUtil._internal();

  String formatCurrency(number) {
    return formatNumber(number, 2);
  }

  String formatNumber(number, [int digit = 0]) {
    var format = "###";
    if (digit > 0) {
      format += ".";
      format += ("0" * digit);
    }
    var f = NumberFormat(format);
    return f.format(number);
  }
}
