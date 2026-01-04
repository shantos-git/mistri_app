import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:mistri_app/firebase_services/firestore.dart';

class JobMapPage extends StatefulWidget {
  final String jobId;
  final String userId;
  final Map<String, dynamic> jobData;

  const JobMapPage({
    super.key,
    required this.jobId,
    required this.userId,
    required this.jobData,
  });

  @override
  State<JobMapPage> createState() => _JobMapPageState();
}

class _JobMapPageState extends State<JobMapPage> {
  final Firestore _firestore = Firestore();
  LatLng? workerLocation;
  LatLng? customerLocation;
  List<LatLng> routePoints = [];
  final MapController _mapController = MapController();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    try {
      final data = widget.jobData;
      final number = data['clientPhone'];
      // Check permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print("Location permissions are denied");
          setState(() {
            _loading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print("Location permissions are permanently denied");
        setState(() {
          _loading = false;
        });
        return;
      }

      // Get worker location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      workerLocation = LatLng(position.latitude, position.longitude);

      print("the use id is ${widget.userId}");

      // Get customer location from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(number)
          .get();

      final userData = userDoc.data() as Map<String, dynamic>?;

      double lat =
          double.tryParse(userData?['latitude']?.toString() ?? '') ?? 0;
      double lng =
          double.tryParse(userData?['longitude']?.toString() ?? '') ?? 0;

      customerLocation = LatLng(lat, lng);

      // Get route from OSRM
      if (workerLocation != null && customerLocation != null) {
        await _getRouteOSRM(workerLocation!, customerLocation!);
      }

      if (mounted) {
        setState(() {
          _loading = false;
        });
        if (workerLocation != null) {
          _mapController.move(workerLocation!, 13.0);
        }
      }
    } catch (e) {
      print("Error loading locations: $e");
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  // Fetch route from OSRM API
  Future<void> _getRouteOSRM(LatLng start, LatLng end) async {
    try {
      final url =
          "https://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?overview=full&geometries=geojson";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final coords = data['routes'][0]['geometry']['coordinates'] as List;

        routePoints = coords
            .map((c) =>
                LatLng((c[1] as num).toDouble(), (c[0] as num).toDouble()))
            .toList();
      } else {
        print("Failed to fetch OSRM route: ${response.body}");
      }
    } catch (e) {
      print("Error fetching OSRM route: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final jobData = widget.jobData;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Job Map"),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Job Card
                Card(
                  margin: const EdgeInsets.all(12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Category: ${jobData['category'] ?? 'N/A'}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Status: ${jobData['status'] ?? 'N/A'}",
                          style: const TextStyle(color: Colors.blue),
                        ),
                        const SizedBox(height: 5),
                        Text(
                            "Client Name: ${jobData['clientName'] ?? 'Unknown'}"),
                        Text(
                            "Client Number: ${jobData['clientPhone'] ?? 'N/A'}"),
                        Text("Address: ${jobData['clientAddress'] ?? 'N/A'}"),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () =>
                                  _firestore.acceptJob(widget.jobId),
                              child: const Text("Accept"),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () =>
                                  _firestore.rejectJob(widget.jobId),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              child: const Text("Reject"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Map
                Expanded(
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: workerLocation ?? LatLng(0, 0),
                      initialZoom: 13.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        userAgentPackageName: 'com.example.mistri_app',
                      ),
                      if (workerLocation != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: workerLocation!,
                              width: 40,
                              height: 40,
                              child: const Icon(
                                Icons.person_pin_circle,
                                color: Colors.blue,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      if (customerLocation != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: customerLocation!,
                              width: 40,
                              height: 40,
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      if (routePoints.isNotEmpty)
                        PolylineLayer(
                          polylines: [
                            Polyline(
                              points: routePoints,
                              color: Colors.green,
                              strokeWidth: 4,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
