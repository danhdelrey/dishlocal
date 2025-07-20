abstract class GenerativeAiService {
  /// Tạo nội dung văn bản dựa trên một prompt và (tùy chọn) một hình ảnh.
  /// Nếu `jsonSchema` được cung cấp, AI sẽ được hướng dẫn trả về một chuỗi JSON tuân thủ schema đó.
  ///
  /// - [prompt]: Câu lệnh hoặc câu hỏi hướng dẫn cho AI.
  /// - [imageUrl]: (Tùy chọn) URL của hình ảnh.
  /// - [jsonSchema]: (Tùy chọn) Một Map đại diện cho JSON schema mà AI phải tuân theo.
  ///
  /// Trả về một [Future<String>]. Nếu có schema, đây sẽ là một chuỗi JSON.
  Future<String> generateContent({
    required String prompt,
    String? imageUrl,
    Map<String, dynamic>? jsonSchema,
  });
}
