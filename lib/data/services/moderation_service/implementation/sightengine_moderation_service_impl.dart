import 'dart:convert';
import 'dart:io';

import 'package:dishlocal/data/services/moderation_service/exception/moderation_service_exception.dart';
import 'package:dishlocal/data/services/moderation_service/interface/moderation_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@LazySingleton(as: ModerationService)
class SightengineModerationServiceImpl implements ModerationService {
  final _log = Logger('SightengineModerationServiceImpl');
  // API endpoint cho kiểm duyệt ảnh
  static const String _imageApiUrl = 'https://api.sightengine.com/1.0/check.json';
  // API endpoint cho kiểm duyệt văn bản
  static const String _textApiUrl = 'https://api.sightengine.com/1.0/text/check.json';
  
  final String _apiUser = dotenv.env['SIGHTENGINE_API_USER'] ?? 'Không tìm thấy key';
  final String _apiSecret = dotenv.env['SIGHTENGINE_API_SECRET'] ?? 'Không tìm thấy key';

  @override
  Future<void> checkImage(File imageFile) async {
    const operationName = 'Kiểm duyệt hình ảnh';
    _log.info('👁️ $operationName: Bắt đầu...');

    try {
      var request = http.MultipartRequest('POST', Uri.parse(_imageApiUrl));
      request.fields['models'] = 'nudity-2.0,wad,offensive';
      request.fields['api_user'] = _apiUser;
      request.fields['api_secret'] = _apiSecret;
      request.files.add(await http.MultipartFile.fromPath('media', imageFile.path));

      _log.fine('📤 $operationName: Đang gửi ảnh đến Sightengine...');
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        _log.fine('✅ $operationName: Nhận được phản hồi: $jsonResponse');

        // KIỂM TRA VI PHẠM VÀ NÉM EXCEPTION
        if (jsonResponse['nudity']['safe'] < 0.8) {
          throw ImageUnsafeException('Nội dung nhạy cảm');
        }
        if (jsonResponse['weapon'] > 0.5) {
          throw ImageUnsafeException('Hình ảnh chứa vũ khí');
        }
        if (jsonResponse['offensive']['prob'] > 0.5) {
          throw ImageUnsafeException('Nội dung gây khó chịu');
        }

        _log.info('👍 $operationName: Hình ảnh được xác định là an toàn.');
        // Nếu không có lỗi, hàm kết thúc bình thường (trả về Future<void>)
        return;
      } else {
        _log.severe('❌ $operationName: Lỗi từ API. Status: ${response.statusCode}, Body: ${response.body}');
        throw ModerationRequestException('Lỗi server (${response.statusCode})');
      }
    } on ImageUnsafeException {
      // Bắt lại để re-throw, tránh bị bắt bởi catch (e) bên dưới
      rethrow;
    } catch (e, st) {
      _log.severe('❌ $operationName: Lỗi không xác định khi gọi API.', e, st);
      throw ModerationRequestException(e.toString());
    }
  }

  @override
  Future<void> checkText(String text) async {
    // Nếu text rỗng, coi như hợp lệ, không cần gọi API
    if (text.trim().isEmpty) {
      _log.info('📝 Văn bản rỗng, bỏ qua kiểm duyệt.');
      return;
    }

    const operationName = 'Kiểm duyệt văn bản';
    _log.info('👁️ $operationName: Bắt đầu...');

    try {
      _log.fine('📤 $operationName: Đang gửi văn bản đến Sightengine...');
      final response = await http.post(
        Uri.parse(_textApiUrl),
        body: {
          'text': text,
          'mode': 'standard', // Chế độ kiểm duyệt chuẩn
          'lang': 'vi', // Chỉ định ngôn ngữ là tiếng Việt để tăng độ chính xác
          'api_user': _apiUser,
          'api_secret': _apiSecret,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        _log.fine('✅ $operationName: Nhận được phản hồi: $jsonResponse');

        // KIỂM TRA VI PHẠM VÀ NÉM EXCEPTION
        // Kiểm tra xem có bất kỳ sự vi phạm nào được phát hiện không
        if (jsonResponse['profanity']['matches'] != null && jsonResponse['profanity']['matches'].isNotEmpty) {
          final firstMatch = jsonResponse['profanity']['matches'][0]['match'];
          throw TextUnsafeException('Chứa từ ngữ không phù hợp ("$firstMatch...")');
        }

        // Bạn có thể thêm các kiểm tra khác ở đây, ví dụ: link, personal info...

        _log.info('👍 $operationName: Văn bản được xác định là an toàn.');
        return;
      } else {
        _log.severe('❌ $operationName: Lỗi từ API. Status: ${response.statusCode}, Body: ${response.body}');
        throw ModerationRequestException('Lỗi server (${response.statusCode})');
      }
    } on TextUnsafeException {
      rethrow;
    } catch (e, st) {
      _log.severe('❌ $operationName: Lỗi không xác định khi gọi API.', e, st);
      throw ModerationRequestException(e.toString());
    }
  }
}
