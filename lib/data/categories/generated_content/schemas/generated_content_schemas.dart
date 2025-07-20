class GeneratedContentSchemas {
  /// Schema để xác thực sự khớp nhau giữa ảnh và tên món ăn.
  ///
  /// Yêu cầu AI trả về một đối tượng JSON với các thuộc tính:
  /// - `isMatch` (boolean): `true` nếu ảnh và tên khớp nhau.
  /// - `reason` (string): Lý do tại sao chúng không khớp (nếu `isMatch` là `false`).
  /// - `correctedDishName` (string): Tên món ăn đúng (nếu AI có thể nhận diện).
  static const Map<String, dynamic> validationSchema = {
    'type': 'object',
    'properties': {
      'isMatch': {
        'type': 'boolean',
        'description': 'Liệu hình ảnh có khớp với tên món ăn được cung cấp không.',
      },
      'reason': {
        'type': 'string',
        'description': 'Nếu không khớp, hãy giải thích ngắn gọn lý do tại sao (ví dụ: "Ảnh là phở bò nhưng tên là bún chả").',
      },
      'correctedDishName': {
        'type': 'string',
        'description': 'Nếu có thể, hãy cung cấp tên chính xác của món ăn trong ảnh.',
      },
    },
    'required': ['isMatch', 'reason'],
  };

  /// Schema để tạo mô tả món ăn.
  ///
  /// Yêu cầu AI trả về một đối tượng JSON chỉ chứa một thuộc tính:
  /// - `description` (string): Nội dung mô tả chi tiết về món ăn.
  static const Map<String, dynamic> descriptionSchema = {
    'type': 'object',
    'properties': {
      'description': {
        'type': 'string',
        'description': 'Một đoạn mô tả ẩm thực hấp dẫn về món ăn.',
      },
    },
    'required': ['description'],
  };
}
