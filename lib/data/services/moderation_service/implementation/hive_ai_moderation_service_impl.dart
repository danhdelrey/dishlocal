import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dishlocal/core/app_environment/app_environment.dart';
import 'package:dishlocal/data/services/moderation_service/exception/moderation_service_exception.dart';
import 'package:dishlocal/data/services/moderation_service/interface/moderation_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@Named('hive.ai')
@LazySingleton(as: ModerationService)
class HiveAiModerationServiceImpl implements ModerationService {
  final _log = Logger('HiveAiModerationServiceImpl');
  final _dio = Dio();
  final _apiKey = AppEnvironment.hiveApiSecretKey;
  static const _hiveApiUrl = 'https://api.thehive.ai/api/v3/hive/text-moderation';

  @override
  Future<void> moderate({String? text, File? imageFile}) async {
    if (text == null || text.trim().isEmpty) {
      _log.info('Text is null or empty, skipping moderation.');
      return;
    }

    _log.info('Starting text moderation for: "$text"');

    final headers = {
      'authorization': 'Bearer $_apiKey',
      'Content-Type': 'application/json',
    };

    final body = {
      'input': [
        {'text': text}
      ]
    };

    final Response response;
    try {
      // BƯỚC 1: Chỉ bao bọc lời gọi mạng trong try-catch
      _log.fine('Sending request to Hive.ai API...');
      _log.finer('URL: $_hiveApiUrl');
      _log.finer('Headers: ${headers.keys}');
      _log.finer('Body: $body');

      response = await _dio.post(
        _hiveApiUrl,
        data: body,
        options: Options(headers: headers),
      );
    } on DioException catch (e, s) {
      // Bắt lỗi mạng/server và ném ra đúng exception
      _log.severe('Hive.ai API request failed.', e, s);
      throw ModerationRequestException('Đã xảy ra lỗi.');
    }

    // BƯỚC 2: Xử lý response bên ngoài try-catch
    // Nếu code chạy đến đây, nghĩa là API call đã thành công (status 200)
    _log.info('Received response from Hive.ai API.');
    _log.fine('Response status code: ${response.statusCode}');
    _log.fine('Response data: ${response.data}');

    // BƯỚC 3: Phân tích kết quả.
    // Nếu hàm này ném ra TextUnsafeException, nó sẽ được truyền thẳng lên tầng trên.
    // Hàm này cũng có thể ném ModerationRequestException nếu response không hợp lệ.
    try {
      _processResponse(response.data);
    } catch (e, s) {
      if (e is ModerationServiceException) {
        // Nếu là exception đã định nghĩa sẵn (TextUnsafeException, ModerationRequestException),
        // thì ném lại nó.
        rethrow;
      }
      // Bắt các lỗi phân tích cú pháp không mong muốn khác
      _log.severe('An unexpected error occurred during response processing.', e, s);
      throw ModerationRequestException('Failed to process API response: $e');
    }
  }

  void _processResponse(Map<String, dynamic> responseData) {
    final output = responseData['output'] as List?;
    if (output == null || output.isEmpty) {
      const errorMessage = 'Invalid response format from Hive.ai API: Missing or empty "output".';
      _log.warning(errorMessage);
      throw ModerationRequestException(errorMessage);
    }

    final results = output.first as Map<String, dynamic>;

    // Sử dụng Set để tự động loại bỏ các vi phạm trùng lặp
    final Set<String> violations = {};

    // --- BƯỚC 1: Kiểm tra danh sách 'classes' (như cũ) ---
    final classes = results['classes'] as List<dynamic>? ?? [];
    for (var moderationClass in classes) {
      final className = moderationClass['class'] as String?;
      final value = moderationClass['value'] as int?;

      if (className != null && value != null && value > 0) {
        violations.add(className);
      }
    }

    // --- BƯỚC 2: Kiểm tra danh sách 'string_matches' (LOGIC MỚI) ---
    final stringMatches = results['string_matches'] as List<dynamic>? ?? [];
    for (var match in stringMatches) {
      final type = match['type'] as String?;
      if (type != null) {
        // Bất kỳ 'type' nào tìm thấy trong string_matches đều được coi là vi phạm.
        // Phổ biến nhất là 'profanity'.
        violations.add(type);
      }
    }

    // --- BƯỚC 3: Quyết định cuối cùng dựa trên danh sách vi phạm tổng hợp ---
    if (violations.isNotEmpty) {
      final reasonForLog = 'Text moderation failed. Violations: ${violations.join(', ')}.';
      _log.warning(reasonForLog);
      // Chuyển Set thành List trước khi ném Exception
      throw TextUnsafeException(violations.toList());
    } else {
      _log.info('Text moderation passed successfully.');
    }
  }
}

/// Lớp tiện ích để dịch các mã vi phạm kiểm duyệt sang tiếng Việt thân thiện với người dùng.
class ModerationViolationTranslator {
  /// Ánh xạ từ mã lỗi của Hive.ai sang tiếng Việt.
  /// Dựa trên tài liệu chính thức: https://docs.thehive.ai/docs/text-moderation-categories
  static const Map<String, String> _dictionary = {
    // --- Các hạng mục chính ---
    'sexual': 'Nội dung khiêu dâm, nhạy cảm',
    'bullying': 'Bắt nạt, quấy rối',
    'hate': 'Ngôn từ gây thù ghét',
    'violence': 'Bạo lực',
    'self_harm': 'Nội dung về tự làm hại bản thân',
    'spam': 'Spam, quảng cáo không mong muốn',
    'drugs': 'Chất cấm, ma túy',
    'weapons': 'Vũ khí, chất nổ',
    'child_safety': 'Nội dung gây hại cho trẻ em',

    // --- Các hạng mục phụ và ít phổ biến hơn ---
    'sexual_description': 'Mô tả hành vi nhạy cảm', // Một biến thể của 'sexual'
    'violent_description': 'Mô tả hành vi bạo lực', // Một biến thể của 'violence'
    'child_exploitation': 'Bóc lột trẻ em', // Một biến thể của 'child_safety'
    'gibberish': 'Nội dung vô nghĩa, khó hiểu',
    'self_harm_intent': 'Ý định tự làm hại bản thân', // Cụ thể hơn 'self_harm'
    'minor_implicitly_mentioned': 'Ám chỉ đến trẻ vị thành niên', // Một biến thể của 'child_safety'
    'minor_explicitly_mentioned': 'Đề cập trực tiếp đến trẻ vị thành niên', // Một biến thể của 'child_safety'
    'phone_number': 'Số điện thoại cá nhân',
    'promotions': 'Khuyến mãi, quảng cáo', // Cụ thể hơn 'spam'
    'redirection': 'Chuyển hướng đến trang web khác', // Thường là spam hoặc lừa đảo

    // --- Các hạng mục khác có thể có ---
    'extremism': 'Nội dung cực đoan, khủng bố',
    'illegal_goods': 'Hàng hóa bất hợp pháp',
    'personal_info': 'Thông tin cá nhân nhạy cảm',
    'profanity': 'Từ ngữ thô tục, xúc phạm', // API có thể trả về hạng mục này
  };

  /// Dịch một danh sách các mã vi phạm sang một câu tiếng Việt hoàn chỉnh.
  ///
  /// Ví dụ: `['sexual', 'hate']` -> "Nội dung không phù hợp vì chứa: Nội dung khiêu dâm, nhạy cảm; Ngôn từ gây thù ghét."
  static String translate(List<String> violations) {
    if (violations.isEmpty) {
      // Trường hợp dự phòng nếu danh sách rỗng nhưng vẫn gọi hàm
      return 'Nội dung không phù hợp.';
    }

    // Lọc ra các bản dịch duy nhất để tránh lặp lại (ví dụ: 'sexual' và 'sexual_description')
    final translatedViolations = violations
        .map((key) => _dictionary[key] ?? key) // Dịch, nếu không có thì dùng key gốc
        .toSet() // Chuyển sang Set để loại bỏ các bản dịch trùng lặp
        .toList();

    // Bạn có thể tùy chỉnh câu thông báo ở đây
    return 'Nội dung không phù hợp vì chứa: ${translatedViolations.join(', ')}.';
  }
}
