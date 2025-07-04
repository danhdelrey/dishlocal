import 'dart:convert';
import 'package:dishlocal/core/app_environment/app_environment.dart';
import 'package:dishlocal/data/services/direction_service/exception/direction_service_exception.dart';
import 'package:dio/dio.dart';
import 'package:dishlocal/data/services/direction_service/api_model/direction_api_model.dart';
import 'package:dishlocal/data/services/direction_service/interface/direction_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@LazySingleton(as: DirectionService)
class MapboxDirectionServiceImpl implements DirectionService {
  final _log = Logger('MapboxDirectionServiceImpl');
  late final Dio _dio;

  MapboxDirectionServiceImpl() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.mapbox.com/directions/v5/mapbox',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
    // Bạn có thể thêm Interceptor để log request/response tự động nếu muốn
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) => _log.fine(obj.toString()),
    ));
  }

  /// Phương thức private để xử lý logic gọi API chung cho cả hai loại route.
  Future<DirectionApiModel> _getRoute({
    required String path,
    required List<List<double>> coordinates,
    String profile = 'driving-traffic',
  }) async {
    // 1. Chuẩn bị URL và Parameters
    if (coordinates.length < 2) {
      _log.severe('Lỗi đầu vào: Cần ít nhất 2 tọa độ để tìm đường.');
      throw InvalidInputException(details: 'Cần ít nhất 2 tọa độ.');
    }

    // Chuyển đổi list tọa độ thành chuỗi theo định dạng "lon1,lat1;lon2,lat2;..."
    final coordinatesString = coordinates.map((c) => '${c[0]},${c[1]}').join(';');

    final fullPath = '/$profile/$coordinatesString';

    final queryParameters = {
      'alternatives': false,
      'annotations': 'distance,duration,speed',
      'banner_instructions': true,
      'geometries': 'geojson',
      'language': 'vi',
      'overview': 'full',
      'roundabout_exits': true,
      'steps': true,
      'voice_instructions': true,
      'voice_units': 'metric', // Đổi thành metric cho hệ mét (km, m)
      'access_token': AppEnvironment.mapboxAccessToken,
    };

    _log.info('Đang gọi Directions API...');
    _log.fine('Endpoint: $fullPath');
    _log.fine('Params: ${jsonEncode(queryParameters)}');

    try {
      // 2. Gọi API
      final response = await _dio.get(fullPath, queryParameters: queryParameters);

      // 3. Xử lý Response
      final responseData = response.data;
      if (responseData == null) {
        _log.severe('Response từ API trống.');
        throw UnknownDirectionException(details: 'Response body is null.');
      }

      final String code = responseData['code'];
      _log.info('API trả về mã: $code');

      if (code == 'Ok') {
        _log.info('Lấy dữ liệu chỉ đường thành công.');
        final model = DirectionApiModel.fromJson(responseData);
        _log.finer('Dữ liệu đã được parse: ${model.routes.first.toString()}');
        return model;
      } else {
        // Ném ra exception tương ứng với mã lỗi từ Mapbox
        final String message = responseData['message'] ?? 'Không có thông báo chi tiết.';
        _log.warning('API trả về lỗi: Code=$code, Message=$message');
        throw DirectionServiceException.fromResponse(code, message);
      }
    } on DioException catch (e) {
      // 4. Xử lý lỗi từ Dio (mạng, timeout, HTTP status codes...)
      _log.severe('Lỗi Dio khi gọi Directions API: ${e.message}', e, e.stackTrace);

      if (e.response != null) {
        // Lỗi từ server (4xx, 5xx)
        final statusCode = e.response!.statusCode;
        switch (statusCode) {
          case 401:
          case 403:
            throw InvalidTokenException();
          case 429:
            throw RateLimitExceededException();
          case 422: // Unprocessable Entity - thường là InvalidInput
            final message = e.response!.data['message'] ?? 'Dữ liệu không hợp lệ.';
            throw InvalidInputException(details: message);
        }
      }
      // Các lỗi khác như timeout, không có kết nối mạng
      throw UnknownDirectionException(details: 'Lỗi kết nối hoặc timeout: ${e.message}');
    } catch (e, stackTrace) {
      // 5. Bắt các lỗi không mong muốn khác (ví dụ lỗi parsing JSON)
      _log.severe('Lỗi không xác định khi xử lý response: ${e.toString()}', e, stackTrace);
      throw UnknownDirectionException(details: e.toString());
    }
  }

  @override
  Future<DirectionApiModel> getDirections({
    required List<List<double>> coordinates,
    String profile = 'driving-traffic',
  }) {
    _log.info('Bắt đầu lấy chỉ đường thông thường.');
    // API thông thường không cần path đặc biệt
    return _getRoute(
      path: '',
      coordinates: coordinates,
      profile: profile,
    );
  }

  @override
  Future<DirectionApiModel> getOptimizedRoute({
    required List<List<double>> coordinates,
    String profile = 'driving-traffic',
  }) {
    _log.info('Bắt đầu lấy chỉ đường tối ưu.');
    // API tối ưu có path khác và cần thêm tham số 'source=first' và 'destination=last'
    // Tuy nhiên, để đơn giản, ta chỉ cần gọi như directions thông thường vì Mapbox
    // Directions API v5 sẽ tự tối ưu nếu có nhiều hơn 2 điểm.
    // Nếu bạn dùng Optimization API riêng thì URL sẽ khác: /mapbox.optimization/v1/
    // Ở đây ta vẫn dùng chung endpoint directions.
    return _getRoute(
      path: '',
      coordinates: coordinates,
      profile: profile,
    );
  }
}
