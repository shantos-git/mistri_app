import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

class UserMapScreen extends StatefulWidget {
  const UserMapScreen({super.key});

  @override
  State<UserMapScreen> createState() => _UserMapScreenState();
}

class _UserMapScreenState extends State<UserMapScreen> {
  MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: LatLng(23.8041, 90.4152),
          initialZoom: 2,
          minZoom: 0,
          maxZoom: 100,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          CurrentLocationLayer(
            style: LocationMarkerStyle(
              marker: DefaultLocationMarker(
                child: Icon(
                  Icons.location_pin,
                  color: Colors.white,
                ),
              ),
              markerSize: Size(35, 35),
              markerDirection: MarkerDirection.heading,
            ),
          ),
        ],
      ),
    );
  }
}
