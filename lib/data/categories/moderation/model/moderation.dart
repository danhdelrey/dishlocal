import 'package:freezed_annotation/freezed_annotation.dart';

part 'moderation.freezed.dart';

/// Enum định nghĩa các loại nội dung có thể được kiểm duyệt.
enum ModerationInputType {
  text,
  image,
}

/// Enum đại diện cho các danh mục nội dung không an toàn.
///
/// Các giá trị này được ánh xạ từ phản hồi của API nhưng được định nghĩa
/// một cách tổng quát để ứng dụng có thể sử dụng mà không phụ thuộc
/// vào tên chính xác từ API.
enum ModerationCategory {
  sexual,
  sexualMinors,
  harassment,
  harassmentThreatening,
  hate,
  hateThreatening,
  illicit,
  illicitViolent,
  selfHarm,
  selfHarmIntent,
  selfHarmInstructions,
  violence,
  violenceGraphic,
  unknown; // Một giá trị dự phòng nếu có danh mục mới từ API

  /// Helper để chuyển đổi từ khóa string của API thành enum.
  /// Điều này giữ cho logic chuyển đổi nằm gọn trong model.
  static ModerationCategory fromApiKey(String key) {
    switch (key) {
      case 'sexual':
        return ModerationCategory.sexual;
      case 'sexual/minors':
        return ModerationCategory.sexualMinors;
      case 'harassment':
        return ModerationCategory.harassment;
      case 'harassment/threatening':
        return ModerationCategory.harassmentThreatening;
      case 'hate':
        return ModerationCategory.hate;
      case 'hate/threatening':
        return ModerationCategory.hateThreatening;
      case 'illicit':
        return ModerationCategory.illicit;
      case 'illicit/violent':
        return ModerationCategory.illicitViolent;
      case 'self-harm':
        return ModerationCategory.selfHarm;
      case 'self-harm/intent':
        return ModerationCategory.selfHarmIntent;
      case 'self-harm/instructions':
        return ModerationCategory.selfHarmInstructions;
      case 'violence':
        return ModerationCategory.violence;
      case 'violence/graphic':
        return ModerationCategory.violenceGraphic;
      default:
        // Ghi lại log về 'key' không xác định ở đây nếu cần
        return ModerationCategory.unknown;
    }
  }
}

/// Đại diện cho một vi phạm cụ thể được phát hiện.
@freezed
abstract class ModerationViolation with _$ModerationViolation {
  const factory ModerationViolation({
    /// Loại nội dung vi phạm (văn bản hay hình ảnh).
    required ModerationInputType inputType,

    /// Danh mục vi phạm.
    required ModerationCategory category,
  }) = _ModerationViolation;
}

/// Đại diện cho kết quả cuối cùng của quá trình kiểm duyệt.
/// Đây là đối tượng mà tầng UI/UseCase sẽ làm việc cùng.
@freezed
abstract class ModerationVerdict with _$ModerationVerdict {
  const ModerationVerdict._(); // Constructor private cho phép thêm getters

  const factory ModerationVerdict({
    /// `true` nếu bất kỳ nội dung nào bị gắn cờ vi phạm.
    required bool isFlagged,

    /// Danh sách chi tiết các vi phạm được phát hiện.
    /// Sẽ là danh sách rỗng nếu `isFlagged` là `false`.
    @Default([]) List<ModerationViolation> violations,
  }) = _ModerationVerdict;

  /// Getter tiện lợi để kiểm tra nhanh có vi phạm trong văn bản không.
  bool get isTextFlagged => violations.any((violation) => violation.inputType == ModerationInputType.text);

  /// Getter tiện lợi để kiểm tra nhanh có vi phạm trong ảnh không.
  bool get isImageFlagged => violations.any((violation) => violation.inputType == ModerationInputType.image);
}
