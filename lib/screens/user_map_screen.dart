import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class UserLocationMap extends StatefulWidget {
  const UserLocationMap({super.key});

  @override
  State<UserLocationMap> createState() => _UserLocationMapState();
}

class _UserLocationMapState extends State<UserLocationMap> {
  final MapController _mapController = MapController();
  LatLng? selectedLatLng;
  String selectedAddress = "Detecting location...";
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setCurrentLocation();
  }

  // 📍 GET CURRENT LOCATION
  Future<void> _setCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position pos = await Geolocator.getCurrentPosition();

    selectedLatLng = LatLng(pos.latitude, pos.longitude);
    _mapController.move(selectedLatLng!, 15);
    await _updateAddress(pos.latitude, pos.longitude);
  }

  // 🧭 LAT LNG → ADDRESS
  Future<void> _updateAddress(double lat, double lng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

    Placemark place = placemarks.first;

    setState(() {
      selectedAddress =
          "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}";
    });
  }

  // 🔎 SEARCH ADDRESS
  Future<void> searchLocation(String query) async {
    final url =
        "https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1";

    final response =
        await http.get(Uri.parse(url), headers: {"User-Agent": "Flutter App"});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data.isNotEmpty) {
        double lat = double.parse(data[0]['lat']);
        double lon = double.parse(data[0]['lon']);

        setState(() {
          selectedLatLng = LatLng(lat, lon);
        });

        _mapController.move(selectedLatLng!, 15);
        await _updateAddress(lat, lon);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Location")),
      body: Column(
        children: [
          // 🔎 SEARCH BOX
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: searchController,
              onSubmitted: searchLocation,
              decoration: InputDecoration(
                hintText: "Search address",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => searchLocation(searchController.text),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // 🗺 MAP
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: LatLng(23.8041, 90.4152),
                initialZoom: 13,
                onPositionChanged: (pos, _) async {
                  if (pos.center != null) {
                    selectedLatLng = pos.center!;
                    await _updateAddress(
                      pos.center!.latitude,
                      pos.center!.longitude,
                    );
                  }
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.mistri.app', // MUST be unique
                ),
                if (selectedLatLng != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: selectedLatLng!,
                        width: 40,
                        height: 40,
                        child: const Icon(
                          Icons.location_pin,
                          size: 40,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),

          // 📌 ADDRESS DISPLAY
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              selectedAddress,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),

          // ✅ CONFIRM
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, {
                "lat": selectedLatLng!.latitude,
                "lng": selectedLatLng!.longitude,
                "address": selectedAddress,
              });
            },
            child: const Text("Confirm Location"),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
