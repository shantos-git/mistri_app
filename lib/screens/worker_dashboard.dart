import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mistri_app/firebase_services/firestore.dart';
import 'package:mistri_app/screens/login_screen.dart';
import 'package:mistri_app/screens/worker_map_screen.dart';
import 'package:rxdart/rxdart.dart';

class WorkerDashboard extends StatefulWidget {
  const WorkerDashboard({super.key});

  @override
  State<WorkerDashboard> createState() => _WorkerDashboardState();
}

class _WorkerDashboardState extends State<WorkerDashboard> {
  final Firestore _firestore = Firestore();

  /// Jobs that already existed when app opened
  final Set<String> _initialJobIds = {};

  /// Jobs already shown as popup
  final Set<String> _popupShownFor = {};

  /// Track first snapshot
  bool _initialJobsCaptured = false;

  /// Combine jobs + users stream
  Stream<List<QuerySnapshot>> _combinedStream() {
    return Rx.combineLatest2<QuerySnapshot, QuerySnapshot, List<QuerySnapshot>>(
      _firestore.getJob(),
      _firestore.getUser(),
      (jobs, users) => [jobs, users],
    );
  }

  /// Safe Firestore string reader
  String safeString(Map<String, dynamic>? map, String key,
      [String defaultValue = "N/A"]) {
    if (map == null) return defaultValue;
    final value = map[key];
    if (value == null) return defaultValue;
    return value.toString();
  }

  /// Show popup once per new job
  void _showJobPopup(String jobId, String category) {
    if (_popupShownFor.contains(jobId)) return;
    _popupShownFor.add(jobId);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("New Job Available"),
          content: Text("Category: $category"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Worker Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
          )
        ],
      ),
      body: StreamBuilder<List<QuerySnapshot>>(
        stream: _combinedStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final jobSnapshot = snapshot.data![0];
          final userSnapshot = snapshot.data![1];

          final jobs = jobSnapshot.docs;
          final users = userSnapshot.docs;

          /// 🧠 Capture initial jobs ONCE (NO popup)
          if (!_initialJobsCaptured) {
            for (var job in jobs) {
              _initialJobIds.add(job.id);
            }
            _initialJobsCaptured = true;
          } else {
            /// 🔥 Detect truly NEW jobs
            for (var job in jobs) {
              if (!_initialJobIds.contains(job.id)) {
                final data = job.data() as Map<String, dynamic>?;
                final status = safeString(data, "status");
                final category = safeString(data, "category");

                if (status == "open") {
                  _showJobPopup(job.id, category);
                }

                _initialJobIds.add(job.id);
              }
            }
          }

          if (jobs.isEmpty) {
            return const Center(child: Text("No jobs available"));
          }

          /// Build user lookup map
          final Map<String, Map<String, dynamic>> userMap = {
            for (var u in users)
              safeString(u.data() as Map<String, dynamic>, "userid"):
                  u.data() as Map<String, dynamic>
          };

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];
              final jobData = job.data() as Map<String, dynamic>?;

              final userId = safeString(jobData, "userid", "");
              final userData = userMap[userId];

              final category = safeString(jobData, "category");
              final status = safeString(jobData, "status");

              final name = safeString(userData, "name", "Unknown");
              final phone = safeString(userData, "Phone_number");
              final address = safeString(userData, "adress");

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => JobMapPage(
                        jobId: job.id,
                        userId: userId,
                        jobData: {
                          "category": category,
                          "status": status,
                          "clientName": name,
                          "clientPhone": phone,
                          "clientAddress": address,
                        },
                      ),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Category: $category",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Status: $status",
                          style: const TextStyle(color: Colors.blue),
                        ),
                        const SizedBox(height: 10),
                        Text("Client Name: $name"),
                        Text("Client Number: $phone"),
                        Text("Address: $address"),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () => _firestore.acceptJob(job.id),
                              child: const Text("Accept"),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () => _firestore.rejectJob(job.id),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text("Reject"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
