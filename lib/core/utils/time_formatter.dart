import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

@lazySingleton
class TimeFormatter {
  static String formatTimeAgo(DateTime time) {
    final now = DateTime.now();
    if (now.difference(time).inDays > 30) {
      return DateFormat('dd/MM/yyyy').format(time);
    }
    return timeago.format(time, locale: 'vi');
  }

  static String formatDateTimeFull(DateTime time) {
    final formatter = DateFormat('HH:mm dd/MM/yyyy');
    return formatter.format(time);
  }
}

class ShortViMessages implements timeago.LookupMessages {
  @override
  String prefixAgo() => ''; // không dùng "trước"
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'Vừa xong';
  @override
  String aboutAMinute(int minutes) => '1 phút';
  @override
  String minutes(int minutes) => '$minutes phút';
  @override
  String aboutAnHour(int minutes) => '1 giờ';
  @override
  String hours(int hours) => '$hours giờ';
  @override
  String aDay(int hours) => '1 ngày';
  @override
  String days(int days) => '$days ngày';
  @override
  String aboutAMonth(int days) => '1 tháng';
  @override
  String months(int months) => '$months tháng';
  @override
  String aboutAYear(int year) => '1 năm';
  @override
  String years(int years) => '$years năm';
  @override
  String wordSeparator() => ' ';
}
