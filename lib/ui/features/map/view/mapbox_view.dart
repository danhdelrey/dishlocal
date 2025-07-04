import 'package:flutter/material.dart';
// Thêm các import cần thiết
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;
import 'package:geolocator/geolocator.dart' as geolocator;

class MapboxView extends StatefulWidget {
  const MapboxView({super.key});

  @override
  State<MapboxView> createState() => _MapboxViewState();
}

class _MapboxViewState extends State<MapboxView> {
  mapbox.MapboxMap? mapboxMap;
  geolocator.Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final hasPermission = await geolocator.Geolocator.checkPermission();
    if (hasPermission == geolocator.LocationPermission.denied) {
      await geolocator.Geolocator.requestPermission();
    }
    final position = await geolocator.Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPosition == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return mapbox.MapWidget(
      key: const ValueKey("mapWidget"),
      cameraOptions: mapbox.CameraOptions(
        center: mapbox.Point(
          coordinates: mapbox.Position(
            _currentPosition!.longitude,
            _currentPosition!.latitude,
          ),
        ),
        zoom: 18.0,
      ),
      styleUri: mapbox.MapboxStyles.MAPBOX_STREETS,
      onMapCreated: (controller) {
        mapboxMap = controller;
      },
    );
  }
}
