import 'package:dio/dio.dart';
import 'package:dishlocal/data/services/geocoding_service/api_models/geocoding_nominatim_response.dart';
import 'package:dishlocal/data/services/geocoding_service/exception/geocoding_service_exception.dart';
import 'package:dishlocal/data/services/geocoding_service/interface/geocoding_service.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@LazySingleton(as: GeocodingService)
class GeocodingServiceNominatimImpl implements GeocodingService {
  final Dio _dio;
  final _log = Logger('GeocodingServiceNominatimImpl');

  // Sử dụng constructor để khởi tạo và cấu hình Dio một lần duy nhất.
  // Đây là nơi lý tưởng để thiết lập các thông số chung như baseUrl và headers.
  GeocodingServiceNominatimImpl()
      : _dio = Dio(BaseOptions(
          baseUrl: 'https://nominatim.openstreetmap.org',
          // RẤT QUAN TRỌNG: Thêm User-Agent để tránh lỗi 403 Forbidden
          // Hãy thay đổi chuỗi này để định danh ứng dụng của bạn
          headers: {
            'User-Agent': 'DishLocal/1.0 (brighttorchstudio@gmail.com)',
          },
          // Thiết lập thời gian chờ để tránh treo ứng dụng
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ));

  @override
  Future<String> getAddressFromPosition(Position position) async {
    _log.fine('Bắt đầu lấy địa chỉ cho tọa độ: ${position.latitude}, ${position.longitude}');
    try {
      // Gọi API với đường dẫn tương đối, vì baseUrl đã được thiết lập
      final response = await _dio.get(
        '/reverse',
        queryParameters: {
          'format': 'jsonv2',
          'lat': position.latitude,
          'lon': position.longitude,
          'accept-language': 'vi',
        },
      );

      // Dio mặc định sẽ ném ra exception cho các status code không phải 2xx.
      // Vì vậy, nếu code chạy đến đây, tức là response.statusCode là 200.
      // Không cần kiểm tra `if (response.statusCode == 200)` nữa.

      final nominatimResponse = GeocodingNominatimResponse.fromJson(response.data);
      final address = nominatimResponse.displayName ?? 'Không tìm thấy địa chỉ';

      _log.fine('Lấy địa chỉ thành công: $nominatimResponse');
      return address;
    } on DioException catch (e) {
      // Xử lý lỗi từ Dio một cách chi tiết hơn
      if (e.response != null) {
        // Lỗi đến từ server (có response trả về, vd: 403, 404, 500)
        _log.severe('Lỗi server khi gọi API Nominatim. Status: ${e.response?.statusCode}, Data: ${e.response?.data}');
        if (e.response?.statusCode == 403) {
          throw GeocodingServiceException('Yêu cầu bị từ chối (403). Vui lòng kiểm tra User-Agent.');
        }
        throw GeocodingServiceException('Lỗi từ server: ${e.response?.statusCode}');
      } else {
        // Lỗi kết nối, không có response (vd: timeout, không có mạng)
        _log.severe('Lỗi kết nối khi gọi API Nominatim: ${e.message}');
        throw GeocodingServiceException('Không thể kết nối đến dịch vụ geocoding.');
      }
    } catch (e, stackTrace) {
      // Bắt các lỗi khác (ví dụ: lỗi parsing JSON)
      _log.severe('Lỗi không xác định khi lấy địa chỉ.', e, stackTrace);
      throw GeocodingServiceException('Đã xảy ra lỗi không mong muốn.');
    }
  }
}
