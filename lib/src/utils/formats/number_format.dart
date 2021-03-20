import 'package:intl/intl.dart';

class NumberFormatHelper {
  static String convertToCurrency(int number) {
    var formatCurrency = new NumberFormat.currency(locale: "ko_KR", symbol: "");
    return formatCurrency.format(number);
  }
}
