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
  final MapController _mapController = MapController();

  LatLng? workerLocation;
  LatLng? customerLocation;
  List<LatLng> routePoints = [];

  bool _loading = true;
  bool _jobAccepted = false;

  @override
  void initState() {
    super.initState();
    _jobAccepted = widget.jobData['status'] == 'accepted';
    _loadLocationsAndRoute(); // 🔥 LOAD MAP + ROUTE IMMEDIATELY
  }

  Future<void> _loadLocationsAndRoute() async {
    try {
      final number = widget.jobData['clientPhone'];

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }
      if (permission == LocationPermission.deniedForever) return;

      // Get worker location
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      workerLocation = LatLng(position.latitude, position.longitude);

      // Get customer location from Firestore
      final userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(number)
          .get();

      final userData = userDoc.data() as Map<String, dynamic>;

      customerLocation = LatLng(
        double.parse(userData['latitude'].toString()),
        double.parse(userData['longitude'].toString()),
      );

      // 🔥 ALWAYS GET ROUTE IMMEDIATELY
      await _getRouteOSRM(workerLocation!, customerLocation!);

      if (mounted) {
        setState(() => _loading = false);
        _mapController.move(workerLocation!, 13);
      }
    } catch (e) {
      debugPrint("Error loading map and route: $e");
      setState(() => _loading = false);
    }
  }

  Future<void> _getRouteOSRM(LatLng start, LatLng end) async {
    final url = "https://router.project-osrm.org/route/v1/driving/"
        "${start.longitude},${start.latitude};"
        "${end.longitude},${end.latitude}"
        "?overview=full&geometries=geojson";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final coords = data['routes'][0]['geometry']['coordinates'];

      routePoints = coords
          .map<LatLng>((c) => LatLng(c[1].toDouble(), c[0].toDouble()))
          .toList();
    }
  }

  Future<void> _acceptJob() async {
    await _firestore.acceptJob(widget.jobId);
    setState(() {
      _jobAccepted = true;
    });
  }

  Future<void> _confirmArrival() async {
    Navigator.pop(context);
    await FirebaseFirestore.instance
        .collection('Jobs')
        .doc(widget.jobId)
        .update({'status': 'arrived'});

    //  DISAPPEARS COMPLETELY
  }

  @override
  Widget build(BuildContext context) {
    final jobData = widget.jobData;

    return Scaffold(
      appBar: AppBar(title: const Text("Job Map")),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                /// JOB CARD
                Card(
                  margin: const EdgeInsets.all(12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Category: ${jobData['category']}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text("Client: ${jobData['clientName']}"),
                        Text("Phone: ${jobData['clientPhone']}"),
                        Text("Address: ${jobData['clientAddress']}"),
                        const SizedBox(height: 10),

                        /// ACCEPT / REJECT
                        if (!_jobAccepted)
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: _acceptJob,
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

                        /// REACHED DESTINATION BUTTON
                        if (_jobAccepted)
                          ElevatedButton.icon(
                            icon: const Icon(Icons.check_circle),
                            label: const Text("Reached Destination"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              minimumSize: const Size(double.infinity, 45),
                            ),
                            onPressed: _confirmArrival,
                          ),
                      ],
                    ),
                  ),
                ),

                /// MAP ALWAYS VISIBLE WITH ROUTE
                Expanded(
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: workerLocation ?? LatLng(0, 0),
                      initialZoom: 13,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        userAgentPackageName: 'com.example.mistri_app',
                      ),
                      MarkerLayer(
                        markers: [
                          if (workerLocation != null)
                            Marker(
                              point: workerLocation!,
                              width: 40,
                              height: 40,
                              child: const Icon(Icons.person_pin_circle,
                                  color: Colors.blue, size: 40),
                            ),
                          if (customerLocation != null)
                            Marker(
                              point: customerLocation!,
                              width: 40,
                              height: 40,
                              child: const Icon(Icons.location_on,
                                  color: Colors.red, size: 40),
                            ),
                        ],
                      ),
                      if (routePoints.isNotEmpty)
                        PolylineLayer(
                          polylines: [
                            Polyline(
                              points: routePoints,
                              strokeWidth: 4,
                              color: Colors.green,
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
