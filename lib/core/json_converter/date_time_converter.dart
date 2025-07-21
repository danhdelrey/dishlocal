import 'package:freezed_annotation/freezed_annotation.dart';

// THAY ĐỔI: Chúng ta sẽ dùng một converter "thô" hơn để tránh lỗi ép kiểu của Dart.
class DateTimeConverter implements JsonConverter<DateTime?, Object?> {
  const DateTimeConverter();

  @override
  DateTime? fromJson(Object? json) {
    // Trực tiếp kiểm tra xem object có phải là String không.
    if (json is String) {
      return DateTime.parse(json).toLocal();
    }
    // Nếu nó là null hoặc kiểu khác, trả về null.
    return null;
  }

  @override
  String? toJson(DateTime? object) {
    if (object == null) {
      return null;
    }
    return object.toUtc().toIso8601String();
  }
}
