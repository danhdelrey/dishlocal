import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

@lazySingleton
class TimeFormatter {
  static String formatTimeAgo(DateTime time) {
    final now = DateTime.now();

    // CHỈ CHUYỂN SANG ĐỊNH DẠNG NGÀY/THÁNG KHI THỜI GIAN VƯỢT QUÁ ~1 NĂM
    // Ngưỡng 360 ngày sẽ cho phép timeago hiển thị "1 tháng", "2 tháng", v.v.
    if (now.difference(time).inDays > 360) {
      // Nếu đã hơn 1 năm, chắc chắn nó không nằm trong năm hiện tại.
      // Vì vậy, ta luôn hiển thị đầy đủ dd/MM/yyyy.
      return DateFormat('dd/MM/yyyy').format(time);
    }

    // Nếu trong vòng 1 năm, hãy để timeago xử lý.
    // Nó sẽ tự chuyển "45 ngày" thành "1 tháng".
    return timeago.format(time, locale: 'vi');
  }

  static String formatDateTimeFull(DateTime time) {
    final formatter = DateFormat('HH:mm dd/MM/yyyy');
    return formatter.format(time);
  }
}

// Lớp ShortViMessages của bạn giữ nguyên
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
  String aboutAMonth(int days) => '1 tháng'; // Sẽ được gọi khi days > 29
  @override
  String months(int months) => '$months tháng'; // Sẽ được gọi khi months > 1
  @override
  String aboutAYear(int year) => '1 năm';
  @override
  String years(int years) => '$years năm';
  @override
  String wordSeparator() => ' ';
}
