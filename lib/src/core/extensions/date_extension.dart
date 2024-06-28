
import 'package:intl/intl.dart';
import 'package:premium_pay_new/export_files.dart';
extension DateUtils on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  String get textInString {
    if (isToday) {
      return "сегодня";
    } else if (isYesterday) {
      return "вчера";
    } else {
      return DateFormat('MMMM d', 'ru_RU').format(this);
    }
  }


  static formatPrice(double price) => '\$ ${toMoney(price)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
}


