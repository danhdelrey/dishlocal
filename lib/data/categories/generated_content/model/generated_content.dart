import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated_content.freezed.dart';
part 'generated_content.g.dart';

/// Đại diện cho nội dung được tạo ra thành công bởi AI.
@freezed
abstract class GeneratedContent with _$GeneratedContent {
  const factory GeneratedContent({
    /// Nội dung mô tả món ăn đã được tạo ra.
    required String generatedContent,
  }) = _GeneratedContent;

  /// Factory constructor để tạo instance từ JSON.
  factory GeneratedContent.fromJson(Map<String, dynamic> json) => _$GeneratedContentFromJson(json);
}
