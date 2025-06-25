import 'dart:convert';
import 'dart:io';

import 'package:dishlocal/core/app_environment/app_environment.dart';
import 'package:dishlocal/data/services/moderation_service/exception/moderation_service_exception.dart';
import 'package:dishlocal/data/services/moderation_service/interface/moderation_service.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@LazySingleton(as: ModerationService)
class SightengineModerationServiceImpl implements ModerationService {
  final _log = Logger('SightengineModerationServiceImpl');
  // API endpoint cho kiểm duyệt ảnh
  static const String _imageApiUrl = 'https://api.sightengine.com/1.0/check.json';
  // API endpoint cho kiểm duyệt văn bản
  //static const String _textApiUrl = 'https://api.sightengine.com/1.0/text/check.json';

  final String _apiUser = AppEnvironment.sightengineApiUser;
  final String _apiSecret = AppEnvironment.sightengineApiSecret;

  void _checkImageSafety(Map<String, dynamic> jsonResponse) {
    // --- ĐỊNH NGHĨA NGƯỠNG KIỂM DUYỆT ---
    // Đặt ngưỡng thấp (0.5) vì ứng dụng chỉ dành cho đồ ăn, cần độ an toàn cao.
    const double sensitiveThreshold = 0.5;

    // --- LẤY CÁC ĐỐI TƯỢNG CON ĐỂ DỄ TRUY CẬP ---
    // Dùng `as` để Dart biết đây là một Map, giúp code an toàn hơn.
    final nudity = jsonResponse['nudity'] as Map<String, dynamic>;
    final offensive = jsonResponse['offensive'] as Map<String, dynamic>;

    // --- ĐIỀU KIỆN IF KIỂM TRA TOÀN DIỆN ---
    if (
        // 1. KIỂM TRA KHỎA THÂN & GỢI DỤC
        // Cách hiệu quả nhất: nếu xác suất "an toàn" (none) thấp, tức là có vấn đề.
        (nudity['none'] as double) < sensitiveThreshold ||

            // Kiểm tra trực tiếp các mục nhạy cảm nhất để chắc chắn
            (nudity['suggestive'] as double) > sensitiveThreshold ||
            (nudity['erotica'] as double) > sensitiveThreshold ||
            (nudity['sexual_activity'] as double) > sensitiveThreshold ||

            // 2. KIỂM TRA VŨ KHÍ
            (jsonResponse['weapon'] as double) > sensitiveThreshold ||

            // 3. KIỂM TRA CHẤT CẤM (RƯỢU, BIA, MA TÚY)
            (jsonResponse['alcohol'] as double) > sensitiveThreshold ||
            (jsonResponse['drugs'] as double) > sensitiveThreshold ||

            // 4. KIỂM TRA NỘI DUNG XÚC PHẠM
            (offensive['prob'] as double) > sensitiveThreshold ||
            (offensive['middle_finger'] as double) > sensitiveThreshold) {
      // Nếu có bất kỳ vi phạm nào, tạo một thông báo lỗi rõ ràng và ném Exception
      final reason = _buildUnsafeReason(jsonResponse, sensitiveThreshold);
      throw ImageUnsafeException('Hình ảnh không phù hợp. Lý do: $reason');
    }

    // Nếu vượt qua tất cả kiểm tra, hình ảnh được coi là an toàn
    _log.info('👍 Hình ảnh được xác định là an toàn.');
  }

  /// Hàm trợ giúp để tìm ra lý do cụ thể hình ảnh bị từ chối.
  /// Giúp cho việc ghi log và gỡ lỗi dễ dàng hơn.
  String _buildUnsafeReason(Map<String, dynamic> jsonResponse, double threshold) {
    final nudity = jsonResponse['nudity'] as Map<String, dynamic>;
    final offensive = jsonResponse['offensive'] as Map<String, dynamic>;

    if ((nudity['sexual_activity'] as double) > threshold) return 'Chứa hoạt động tình dục';
    if ((nudity['erotica'] as double) > threshold) return 'Chứa nội dung khiêu dâm';
    if ((nudity['suggestive'] as double) > threshold) return 'Chứa nội dung gợi dục';
    if ((jsonResponse['weapon'] as double) > threshold) return 'Phát hiện vũ khí';
    if ((jsonResponse['alcohol'] as double) > threshold) return 'Phát hiện rượu/bia';
    if ((jsonResponse['drugs'] as double) > threshold) return 'Phát hiện chất cấm';
    if ((offensive['prob'] as double) > threshold) return 'Chứa nội dung xúc phạm';

    return 'Nội dung không xác định nhưng bị nghi ngờ là không an toàn';
  }

  @override
  Future<void> moderate({String? text, File? imageFile}) async {
    // 1. Kiểm tra điều kiện đầu vào
    if (text == null && imageFile == null) {
      _log.warning('⚠️ Yêu cầu kiểm duyệt không có nội dung (text và imageFile đều null).');
      // Có thể ném lỗi hoặc return tùy theo logic ứng dụng
      throw ArgumentError('Cần cung cấp ít nhất text hoặc imageFile để kiểm duyệt.');
    }

    // 2. Xử lý kiểm duyệt văn bản (nếu có)
    if (text != null && text.trim().isNotEmpty) {
      _log.info('📝 Bắt đầu kiểm duyệt văn bản...');
      // TODO: Thêm logic kiểm duyệt văn bản của bạn ở đây.
      // Ví dụ: await _moderateText(text);
      _log.info('✅ (Giả lập) Kiểm duyệt văn bản hoàn tất.');
    }

    // 3. Xử lý kiểm duyệt hình ảnh (nếu có)
    if (imageFile != null) {
      await _moderateImage(imageFile);
    }
  }

  /// Phương thức riêng để xử lý việc gọi API kiểm duyệt hình ảnh.
  /// Logic này được giữ nguyên từ phiên bản gốc của bạn.
  Future<void> _moderateImage(File imageFile) async {
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

        // Gọi hàm kiểm tra nội dung JSON
        _checkImageSafety(jsonResponse);

        // Nếu không có lỗi, hàm kết thúc bình thường
        return;
      } else {
        _log.severe('❌ $operationName: Lỗi từ API. Status: ${response.statusCode}, Body: ${response.body}');
        throw ModerationRequestException('Lỗi server (${response.statusCode})');
      }
    } on ImageUnsafeException {
      // Bắt lại để re-throw, tránh bị bắt bởi catch (e) chung bên dưới
      rethrow;
    } catch (e, st) {
      _log.severe('❌ $operationName: Lỗi không xác định khi gọi API.', e, st);
      // Ném ra exception chung hơn để lớp gọi có thể xử lý
      throw ModerationRequestException('Lỗi không xác định khi kiểm duyệt hình ảnh');
    }
  }
  
  

  
}
