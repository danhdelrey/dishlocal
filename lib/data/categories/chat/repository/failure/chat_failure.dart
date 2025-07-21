import 'package:dishlocal/data/error/repository_failure.dart';

sealed class ChatFailure extends RepositoryFailure {
  const ChatFailure(super.message);
}

/// Lỗi xảy ra khi một thao tác chung (ví dụ: gọi RPC) thất bại
/// vì lý do mạng, lỗi server, hoặc các lỗi không xác định khác.
class ChatOperationFailure extends ChatFailure {
  const ChatOperationFailure(super.message);
}

/// Lỗi xảy ra khi cố gắng truy cập một cuộc trò chuyện không tồn tại.
class ConversationNotFoundFailure extends ChatFailure {
  const ConversationNotFoundFailure() : super("Không tìm thấy cuộc trò chuyện này.");
}

/// Lỗi xảy ra khi người dùng không có quyền thực hiện một hành động,
/// ví dụ như gửi tin nhắn vào một cuộc trò chuyện mà họ không phải là thành viên.
/// Lỗi này thường xuất phát từ chính sách RLS (Row Level Security) của Supabase.
class ChatPermissionDenied extends ChatFailure {
  const ChatPermissionDenied() : super("Bạn không có quyền thực hiện hành động này.");
}

/// Lỗi xảy ra khi cố gắng tạo cuộc trò chuyện với một user không tồn tại.
class UserNotFoundFailure extends ChatFailure {
  const UserNotFoundFailure() : super("Không tìm thấy người dùng được chỉ định.");
}
