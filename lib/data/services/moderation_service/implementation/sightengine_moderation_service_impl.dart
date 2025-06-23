import 'dart:convert';
import 'dart:io';

import 'package:dishlocal/data/services/moderation_service/exception/moderation_service_exception.dart';
import 'package:dishlocal/data/services/moderation_service/interface/moderation_service.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@LazySingleton(as: ModerationService)
class SightengineModerationServiceImpl implements ModerationService {
  final _log = Logger('SightengineModerationServiceImpl');
  static const String _apiUrl = 'https://api.sightengine.com/1.0/check.json';
  //TODO LƯU Ý: Lưu các key này vào file .env, không hard-code!
  final String _apiUser = 'YOUR_SIGHTENGINE_API_USER';
  final String _apiSecret = 'YOUR_SIGHTENGINE_API_SECRET';

  @override
  Future<void> checkImage(File imageFile) async {
    const operationName = 'Kiểm duyệt hình ảnh';
    _log.info('👁️ $operationName: Bắt đầu...');

    try {
      var request = http.MultipartRequest('POST', Uri.parse(_apiUrl));
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
}
