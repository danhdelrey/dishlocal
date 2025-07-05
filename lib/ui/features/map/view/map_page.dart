import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/app_environment/app_environment.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/core/utils/number_formatter.dart';
import 'package:dishlocal/core/utils/time_formatter.dart';
import 'package:dishlocal/data/categories/direction/model/direction.dart';
import 'package:dishlocal/data/categories/direction/model/location_data.dart';
import 'package:dishlocal/ui/features/map/bloc/map_bloc.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_icon_with_label.dart';
import 'package:flutter/material.dart' hide Preview;
import 'package:flutter/services.dart'; // Cần cho rootBundle
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as geo;

class MapPage extends StatelessWidget {
  const MapPage({super.key, required this.destination, required this.destinationName});

  final LocationData destination;
  final String destinationName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MapBloc>(),
      child: MapView(
        destination: destination,
        destinationName: destinationName,
      ),
    );
  }
}

class MapView extends StatefulWidget {
  const MapView({super.key, required this.destination, required this.destinationName});
  final LocationData destination;
  final String destinationName;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  // Các biến quản lý Mapbox, giữ nguyên
  MapboxMap? _mapboxMap;
  PointAnnotationManager? _pointAnnotationManager;
  Uint8List? _markerImage;
  PointAnnotation? _destinationAnnotation;

  // ID cho source và layer, giữ nguyên
  static const _routeSourceId = "route-source";
  static const _routeLayerId = "route-layer";

  // Biến completer để đảm bảo map đã sẵn sàng trước khi vẽ
  final Completer<void> _mapReadyCompleter = Completer();

  @override
  void initState() {
    super.initState();
    _loadMarkerImage();

    // Trigger sự kiện tải tuyến đường khi widget khởi tạo
    _requestInitialRoute();
  }

  // Hàm này sẽ gọi BLoC để yêu cầu tuyến đường
  Future<void> _requestInitialRoute() async {
    try {
      // Logic lấy vị trí người dùng và điểm đến vẫn nằm ở đây
      // vì nó là dữ liệu đầu vào cho BLoC.
      final startPosition = await _getUserLocation();

      // Gửi sự kiện tới BLoC
      // ignore: use_build_context_synchronously
      context.read<MapBloc>().add(
            MapEvent.routeRequested(
              coordinates: [
                [startPosition.longitude, startPosition.latitude],
                [widget.destination.longitude, widget.destination.latitude], // Tọa độ điểm đến
              ],
            ),
          );
    } catch (e) {
      // Nếu không lấy được vị trí ban đầu, có thể xử lý lỗi ở đây
      // hoặc để BLoC xử lý (nếu bạn thiết kế BLoC nhận lỗi này)
      // Hiện tại, ta sẽ hiển thị SnackBar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi khi lấy vị trí ban đầu: ${e.toString()}')));
      }
    }
  }

  // Tải ảnh marker từ assets và lưu vào biến (giữ nguyên)
  Future<void> _loadMarkerImage() async {
    final ByteData bytes = await rootBundle.load('assets/images/location_marker.png');
    if (mounted) {
      setState(() {
        _markerImage = bytes.buffer.asUint8List();
      });
    }
  }

  // Hàm vẽ tuyến đường, giờ nhận vào dữ liệu từ BLoC
  Future<void> _drawRoute(List<List<double>> coordinates) async {
    await _mapReadyCompleter.future;
    if (_mapboxMap == null) return;

    final routeGeometry = LineString(coordinates: coordinates.map((coord) => Position(coord[0], coord[1])).toList());

    try {
      await _mapboxMap!.style.removeStyleLayer(_routeLayerId);
      await _mapboxMap!.style.removeStyleSource(_routeSourceId);
    } catch (_) {}

    await _mapboxMap!.style.addSource(GeoJsonSource(
      id: _routeSourceId,
      data: json.encode(routeGeometry.toJson()),
    ));

    final routeLayer = LineLayer(
      id: _routeLayerId,
      sourceId: _routeSourceId,
      lineColor: Colors.blue.toARGB32(),
      lineWidth: 7.0,
      lineOpacity: 0.8,
      lineJoin: LineJoin.ROUND,
      lineCap: LineCap.ROUND,
    );

    await _mapboxMap!.style.addLayer(routeLayer);

    // Logic đặt layer puck bên trên vẫn giữ nguyên
    const knownPuckLayerIds = ['puck', 'mapbox-location-indicator-layer'];
    String? puckLayerId;
    final styleLayers = await _mapboxMap!.style.getStyleLayers();

    for (final layer in styleLayers) {
      if (knownPuckLayerIds.contains(layer?.id)) {
        puckLayerId = layer?.id;
        break;
      }
    }
    if (puckLayerId != null) {
      await _mapboxMap!.style.moveStyleLayer(_routeLayerId, LayerPosition(below: puckLayerId));
    }
  }

  // Hàm thêm marker, giờ nhận tọa độ từ BLoC
  Future<void> _addDestinationMarker(List<double> destination, String name) async {
    await _mapReadyCompleter.future;
    if (_pointAnnotationManager == null || _markerImage == null) return;

    // Nếu đã có marker điểm đến cũ, hãy xóa nó đi
    if (_destinationAnnotation != null) {
      await _pointAnnotationManager!.delete(_destinationAnnotation!);
    }

    // Tạo marker mới và lưu lại để có thể xóa trong lần cập nhật sau
    _destinationAnnotation = await _pointAnnotationManager!.create(
      PointAnnotationOptions(
        geometry: Point(coordinates: Position(destination[0], destination[1])),
        image: _markerImage!,
        iconAnchor: IconAnchor.BOTTOM,
        textField: name,
        textColor: Colors.black.toARGB32(),
        textHaloColor: Colors.white.toARGB32(),
        textHaloWidth: 2.0,
        textSize: 14.0,
        textOffset: [0.0, -2],
        textAnchor: TextAnchor.BOTTOM,
      ),
    );
  }

  Future<void> _addIslandLabels() async {
    await _mapReadyCompleter.future;
    if (_pointAnnotationManager == null) return;

    // Tọa độ trung tâm của Hoàng Sa và Trường Sa
    final hoangSaPosition = Position(112.0, 16.5); // Kinh độ, Vĩ độ
    final truongSaPosition = Position(114.16, 9.25); // Kinh độ, Vĩ độ

    await _pointAnnotationManager!.createMulti([
      // Nhãn cho Quần đảo Hoàng Sa
      PointAnnotationOptions(
        geometry: Point(coordinates: hoangSaPosition),
        textField: 'Quần đảo Hoàng Sa (Việt Nam)',
        textColor: Colors.blue.shade900.toARGB32(),
        textHaloColor: Colors.white.toARGB32(),
        textHaloWidth: 2.0,
        textSize: 12.0,
        textAnchor: TextAnchor.CENTER,
      ),
      // Nhãn cho Quần đảo Trường Sa
      PointAnnotationOptions(
        geometry: Point(coordinates: truongSaPosition),
        textField: 'Quần đảo Trường Sa (Việt Nam)',
        textColor: Colors.blue.shade900.toARGB32(),
        textHaloColor: Colors.white.toARGB32(),
        textHaloWidth: 2.0,
        textSize: 12.0,
        textAnchor: TextAnchor.CENTER,
      ),
    ]);
  }

  // Hàm điều chỉnh camera, giờ nhận dữ liệu từ BLoC
  Future<void> _adjustCamera(Direction direction) async {
    await _mapReadyCompleter.future;
    if (_mapboxMap == null || direction.waypoints!.length < 2) return;

    // Lấy tọa độ từ Waypoints trong model Direction
    final startPoint = Point(coordinates: Position(direction.waypoints!.first.location![0], direction.waypoints!.first.location![1]));
    final endPoint = Point(coordinates: Position(direction.waypoints!.last.location![0], direction.waypoints!.last.location![1]));

    final bounds = await _mapboxMap!.cameraForCoordinates([startPoint, endPoint], MbxEdgeInsets(top: 100, left: 50, bottom: 100, right: 50), null, null);

    await _mapboxMap!.flyTo(bounds, MapAnimationOptions(duration: 2000));
  }

  // Lấy vị trí người dùng (giữ nguyên)
  Future<geo.Position> _getUserLocation() async {
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

  // Zoom tới vị trí hiện tại (giữ nguyên)
  Future<void> _zoomToCurrentUserLocation() async {
    if (_mapboxMap == null) return;
    try {
      final geo.Position currentPosition = await _getUserLocation();
      final cameraOptions = CameraOptions(
        center: Point(coordinates: Position(currentPosition.longitude, currentPosition.latitude)),
        zoom: 17.0,
      );
      await _mapboxMap!.flyTo(cameraOptions, MapAnimationOptions(duration: 1500));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi khi lấy vị trí: ${e.toString()}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapBloc, MapState>(
      // listener để xử lý các hành động không cần rebuild UI
      listener: (context, state) {
        if (state is Preview) {
          // Khi có dữ liệu, gọi các hàm vẽ
          final direction = state.direction;
          if (direction.routes!.isNotEmpty && direction.waypoints!.isNotEmpty) {
            final route = direction.routes!.first;
            final destinationWaypoint = direction.waypoints!.last;

            _drawRoute(route.geometry?.coordinates ?? [[]]);
            _addDestinationMarker(destinationWaypoint.location ?? [], widget.destinationName);
            _adjustCamera(direction);
          }
        }
        // Bạn có thể thêm các listener khác ở đây, ví dụ cho trạng thái Navigating
      },
      // builder để xây dựng các widget trên màn hình
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            title: InkWell(
              onTap: () {
                context.pop();
              },
              borderRadius: BorderRadius.circular(1000),
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(1000),
                  boxShadow: [
                    BoxShadow(
                      color: appColorScheme(context).outline.withValues(alpha: 0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 5),
                  child: CustomIconWithLabel(
                    icon: AppIcons.left.toSvg(
                      color: Colors.black,
                      width: 16,
                      height: 16,
                    ),
                    label: 'Quay về',
                    labelColor: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: state is Preview
              ? Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: appColorScheme(context).outline.withValues(alpha: 0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.directions_car, color: Colors.blue),
                          const SizedBox(width: 8),
                          Text(
                            NumberFormatter.formatDistance(state.direction.routes?.first.distance),
                            style: appTextTheme(context).titleMedium?.copyWith(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(Icons.timer, color: Colors.green),
                          const SizedBox(width: 8),
                          Text(
                            NumberFormatter.formatDuration(state.direction.routes?.first.duration),
                            style: appTextTheme(context).titleMedium?.copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : null,
          // Sử dụng BlocConsumer để xử lý cả UI và các side-effect (như vẽ bản đồ)
          body: Stack(
            children: [
              MapWidget(
                key: const ValueKey("mapWidget"),
                cameraOptions: CameraOptions(
                  center: Point(coordinates: Position(108.2772, 16.0544)), // Tọa độ Đà Nẵng
                  zoom: 0, // Zoom ra xa hơn
                  pitch: 0.0,
                  bearing: 0.0,
                ),
                onMapCreated: (controller) async {
                  _mapboxMap = controller;
                  _pointAnnotationManager = await _mapboxMap!.annotations.createPointAnnotationManager();

                  controller.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
                  controller.compass.updateSettings(CompassSettings(enabled: false));
                  controller.logo.updateSettings(LogoSettings(enabled: false));
                  controller.attribution.updateSettings(AttributionSettings(enabled: false));

                  if (!_mapReadyCompleter.isCompleted) {
                    _mapReadyCompleter.complete();
                  }

                  _addIslandLabels();
                },
                onStyleLoadedListener: (_) {
                  _mapboxMap?.location.updateSettings(LocationComponentSettings(
                    enabled: true,
                    puckBearingEnabled: true,
                    puckBearing: PuckBearing.HEADING,
                  ));
                },
              ),
              // Hiển thị loading indicator dựa trên state của BLoC
              if (state is LoadInProgress)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              // Hiển thị lỗi dựa trên state của BLoC
              if (state is LoadFailure)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Material(
                    child: Container(
                      color: Colors.redAccent,
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        state.failure.message, // Lấy message từ failure object
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: appColorScheme(context).primary,
            onPressed: _zoomToCurrentUserLocation,
            tooltip: 'Vị trí của tôi',
            shape: const CircleBorder(),
            child: const Icon(Icons.my_location),
          ),
        );
      },
    );
  }
}
