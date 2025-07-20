import 'package:dishlocal/data/error/repository_failure.dart';

sealed class GeneratedContentFailure extends RepositoryFailure {
  const GeneratedContentFailure(super.message);
}


/// Lỗi xảy ra do sự cố mạng (không có kết nối, timeout).
class NetworkFailure extends GeneratedContentFailure {
  const NetworkFailure() : super('Không thể kết nối đến máy chủ. Vui lòng kiểm tra lại kết nối mạng của bạn.');
}

/// Lỗi xảy ra khi API key không hợp lệ hoặc bị từ chối.
class ApiKeyFailure extends GeneratedContentFailure {
  const ApiKeyFailure() : super('Lỗi xác thực. Không thể truy cập dịch vụ AI.');
}

/// Lỗi xảy ra do server của AI gặp sự cố.
class ServerFailure extends GeneratedContentFailure {
  const ServerFailure() : super('Dịch vụ đang tạm thời gián đoạn. Vui lòng thử lại sau.');
}

/// Lỗi xảy ra khi đầu vào (ảnh, tên món ăn) không hợp lệ.
class InvalidInputFailure extends GeneratedContentFailure {
  const InvalidInputFailure() : super('Hình ảnh hoặc thông tin cung cấp không hợp lệ.');
}

/// Lỗi xảy ra khi AI không thể tạo ra nội dung (bị chặn, không có kết quả).
class ContentGenerationFailure extends GeneratedContentFailure {
  const ContentGenerationFailure({String message = 'Không thể tạo mô tả cho nội dung này.'}) : super(message);
}

/// Lỗi không xác định khác.
class UnknownFailure extends GeneratedContentFailure {
  const UnknownFailure() : super('Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại.');
}

/// Lỗi xảy ra khi tên món ăn cung cấp không có ý nghĩa hoặc không hợp lệ.
class InvalidDishNameFailure extends GeneratedContentFailure {
  const InvalidDishNameFailure() : super('Tên món ăn được cung cấp không hợp lệ.');
}

/// Lỗi xảy ra khi hình ảnh và tên món ăn không khớp với nhau.
class MismatchedContentFailure extends GeneratedContentFailure {
  const MismatchedContentFailure() : super('Hình ảnh không khớp với tên món ăn được cung cấp.');
}
