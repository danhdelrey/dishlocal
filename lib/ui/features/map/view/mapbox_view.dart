import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/app_environment/app_environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Cần cho rootBundle
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:http/http.dart' as http;
import 'package:turf/turf.dart' as turf;

class MapboxView extends StatefulWidget {
  const MapboxView({super.key});

  @override
  State<MapboxView> createState() => _MapboxViewState();
}

class _MapboxViewState extends State<MapboxView> {
  // Các biến quản lý trạng thái
  MapboxMap? _mapboxMap;
  PointAnnotationManager? _pointAnnotationManager;
  Uint8List? _markerImage; // Biến lưu dữ liệu ảnh marker

  bool _isLoading = true;
  String? _errorMessage;

  static const _routeSourceId = "route-source";
  static const _routeLayerId = "route-layer";

  final Completer<void> _mapReadyCompleter = Completer();

  @override
  void initState() {
    super.initState();
    _loadMarkerImage(); // Tải ảnh marker khi widget khởi tạo
    _initializeMapAndRoute();
  }

  // Tải ảnh marker từ assets và lưu vào biến
  Future<void> _loadMarkerImage() async {
    final ByteData bytes = await rootBundle.load('assets/images/location_marker.png');
    setState(() {
      _markerImage = bytes.buffer.asUint8List();
    });
  }

  Future<void> _initializeMapAndRoute() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final startPosition = await _getUserLocation();
      final destinationPosition = _calculateDestination(startPosition);
      final routeCoordinates = await _fetchRoute(startPosition, destinationPosition);

      await _mapReadyCompleter.future;

      await _drawRoute(routeCoordinates);
      await _addDestinationMarker(destinationPosition); // Thêm marker tại điểm đến
      await _adjustCamera(startPosition, destinationPosition);
    } catch (e) {
      setState(() {
        _errorMessage = "Lỗi: ${e.toString()}";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Thêm một marker với nhãn tại điểm đến
  Future<void> _addDestinationMarker(geo.Position destination) async {
    // Đảm bảo manager và ảnh đã sẵn sàng
    if (_pointAnnotationManager == null || _markerImage == null) return;

    // Xóa các marker cũ để tránh trùng lặp khi tải lại
    await _pointAnnotationManager!.deleteAll();

    // Tạo chú thích điểm (marker)
    await _pointAnnotationManager!.create(
      PointAnnotationOptions(
        geometry: Point(coordinates: Position(destination.longitude, destination.latitude)),
        image: _markerImage!,
        iconAnchor: IconAnchor.BOTTOM, // Đặt điểm neo ở dưới cùng của icon
        textField: 'Quán ăn Hai Lúa',
        textColor: Colors.black.toARGB32(),
        textSize: 14.0,
        textOffset: [0.0, -2], // Dịch chuyển văn bản lên trên icon
        textAnchor: TextAnchor.BOTTOM, // Neo văn bản ở cạnh dưới của nó
      ),
    );
  }

  Future<geo.Position> _getUserLocation() async {
    // ... (code không đổi)
    bool serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Dịch vụ vị trí đã bị tắt.';
    }

    geo.LocationPermission permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();
      if (permission == geo.LocationPermission.denied) {
        throw 'Quyền truy cập vị trí đã bị từ chối.';
      }
    }

    if (permission == geo.LocationPermission.deniedForever) {
      throw 'Quyền truy cập vị trí đã bị từ chối vĩnh viễn.';
    }

    return await geo.Geolocator.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high);
  }

  geo.Position _calculateDestination(geo.Position start) {
    // ... (code không đổi)
    final startPoint = turf.Point(coordinates: turf.Position(start.longitude, start.latitude));
    final destinationFeature = turf.destination(startPoint, 10, 90, turf.Unit.kilometers);

    final destCoords = destinationFeature.coordinates;
    return geo.Position(latitude: destCoords.lat as double, longitude: destCoords.lng as double, timestamp: DateTime.now(), accuracy: 0, altitude: 0, altitudeAccuracy: 0, heading: 0, headingAccuracy: 0, speed: 0, speedAccuracy: 0);
  }

  Future<List<Position>> _fetchRoute(geo.Position start, geo.Position end) async {
    final url = 'https://api.mapbox.com/directions/v5/mapbox/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?overview=full&geometries=geojson&access_token=${AppEnvironment.mapboxAccessToken}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final List<dynamic> coordinates = decoded['routes'][0]['geometry']['coordinates'];
      return coordinates.map((coord) => Position(coord[0], coord[1])).toList();
    } else {
      throw 'Không thể lấy dữ liệu chỉ đường. Status code: ${response.statusCode}';
    }
  }

  Future<void> _drawRoute(List<Position> coordinates) async {
    if (_mapboxMap == null) return;

    // Xóa tuyến đường cũ nếu có
    try {
      await _mapboxMap!.style.removeStyleLayer(_routeLayerId);
      await _mapboxMap!.style.removeStyleSource(_routeSourceId);
    } catch (_) {
      // Bỏ qua lỗi nếu layer/source chưa tồn tại
    }

    // Tạo một LineString từ các tọa độ
    final routeGeometry = LineString(coordinates: coordinates);

    // Thêm source dữ liệu GeoJSON
    await _mapboxMap!.style.addSource(GeoJsonSource(
      id: _routeSourceId,
      data: json.encode(routeGeometry.toJson()),
    ));

    // Tạo đối tượng layer
    final routeLayer = LineLayer(
      id: _routeLayerId,
      sourceId: _routeSourceId,
      lineColor: Colors.blue.toARGB32(),
      lineWidth: 7.0, // Tăng độ rộng một chút để dễ nhìn
      lineOpacity: 0.8,
      lineJoin: LineJoin.ROUND,
      lineCap: LineCap.ROUND,
    );

    // Thêm layer vào bản đồ trước
    await _mapboxMap!.style.addLayer(routeLayer);

    // --- LOGIC SỬA LẠI ĐỂ ĐẶT LAYER ĐÚNG VỊ TRÍ ---

    // Lấy danh sách ID của các layer puck có thể có trên iOS và Android
    const knownPuckLayerIds = [
      'puck', // ID trên iOS
      'mapbox-location-indicator-layer' // ID trên Android
    ];

    String? puckLayerId;
    final styleLayers = await _mapboxMap!.style.getStyleLayers();

    // Tìm ID chính xác của layer puck đang được sử dụng
    for (final layer in styleLayers) {
      if (knownPuckLayerIds.contains(layer?.id)) {
        puckLayerId = layer?.id;
        break;
      }
    }

    // Nếu tìm thấy layer của puck, di chuyển layer tuyến đường xuống ngay bên dưới nó.
    // Điều này đảm bảo puck luôn nằm trên tuyến đường.
    if (puckLayerId != null) {
      await _mapboxMap!.style.moveStyleLayer(_routeLayerId, LayerPosition(below: puckLayerId));
    }
  }

  Future<void> _adjustCamera(geo.Position start, geo.Position end) async {
    if (_mapboxMap == null) return;

    // <-- CHỨC NĂNG ZOOM ĐỂ THẤY TOÀN BỘ TUYẾN ĐƯỜNG NẰM Ở ĐÂY
    final bounds = await _mapboxMap!.cameraForCoordinates(
        [
          Point(coordinates: Position(start.longitude, start.latitude)),
          Point(coordinates: Position(end.longitude, end.latitude)),
        ],

        // Thêm padding để tuyến đường không bị sát viền màn hình
        MbxEdgeInsets(top: 100, left: 50, bottom: 100, right: 50),
        null,
        null);

    await _mapboxMap!.flyTo(bounds, MapAnimationOptions(duration: 3000));
  }

  Future<void> _zoomToCurrentUserLocation() async {
    if (_mapboxMap == null) return;

    try {
      final geo.Position currentPosition = await _getUserLocation();

      // Tạo các tùy chọn cho camera
      final cameraOptions = CameraOptions(
        center: Point(coordinates: Position(currentPosition.longitude, currentPosition.latitude)),
        zoom: 18.5, // Mức zoom cao để nhìn rõ đường phố
        //pitch: 60.0, // Giữ góc nhìn 3D
        bearing: 0, // Hướng về phía Bắc
      );

      // Thực hiện hiệu ứng "bay" đến vị trí
      await _mapboxMap!.flyTo(cameraOptions, MapAnimationOptions(duration: 1500));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi khi lấy vị trí: ${e.toString()}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉ Đường Tới Điểm Cách 1km'),
      ),
      body: Stack(
        children: [
          MapWidget(
            key: const ValueKey("mapWidget"),
            onMapCreated: (controller) async {
              _mapboxMap = controller;
              // Khởi tạo PointAnnotationManager sau khi map được tạo
              _pointAnnotationManager = await _mapboxMap!.annotations.createPointAnnotationManager();
              if (!_mapReadyCompleter.isCompleted) {
                _mapReadyCompleter.complete();
              }
            },
            onStyleLoadedListener: (_) {
              _mapboxMap?.location.updateSettings(LocationComponentSettings(
                enabled: true,
                puckBearingEnabled: true,
                puckBearing: PuckBearing.HEADING,
              ));
            },
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (_errorMessage != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Material(
                child: Container(
                  color: Colors.redAccent,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _zoomToCurrentUserLocation, // Gọi hàm mới
        tooltip: 'Vị trí của tôi', // Thay đổi tooltip
        child: const Icon(Icons.my_location), // Thay đổi icon
      ),
    );
  }
}
