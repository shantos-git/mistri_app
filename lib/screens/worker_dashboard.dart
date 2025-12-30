import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mistri_app/firebase_services/firestore.dart';
import 'package:mistri_app/screens/login_screen.dart';
import 'package:rxdart/rxdart.dart';

class WorkerDashboard extends StatefulWidget {
  const WorkerDashboard({super.key});

  @override
  State<WorkerDashboard> createState() => _WorkerDashboardState();
}

class _WorkerDashboardState extends State<WorkerDashboard> {
  final Firestore _firestore = Firestore();

  /// Track jobs already seen to avoid duplicate popups
  final Set<String> _seenJobIdsForPopup = {};

  /// Combine open jobs and users in real-time
  Stream<List<dynamic>> _combinedStream() {
    return Rx.combineLatest2(
      _firestore.getJob(), // open jobs only
      _firestore.getUser(),
      (jobs, users) => [jobs, users],
    );
  }

  /// Helper to safely read strings from Firestore
  String safeString(Map<String, dynamic>? map, String key,
      [String defaultValue = "N/A"]) {
    if (map == null) return defaultValue;
    final value = map[key];
    if (value == null) return defaultValue;
    return value.toString();
  }

  /// Show popup for new job
  void _showJobNotification(String jobId, String category) {
    if (_seenJobIdsForPopup.contains(jobId)) return;
    _seenJobIdsForPopup.add(jobId);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          title: const Text("New Job Available"),
          content: Text("Category: $category"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
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
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.logout,
              ))
        ],
      ),
      body: StreamBuilder<List<dynamic>>(
        stream: _combinedStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final jobSnap = snapshot.data![0] as QuerySnapshot;
          final userSnap = snapshot.data![1] as QuerySnapshot;

          final jobs = jobSnap.docs;
          final users = userSnap.docs;

          if (jobs.isEmpty) {
            return const Center(child: Text("No jobs available"));
          }

          // Build user map for fast lookup (key = userid)
          final Map<String, Map<String, dynamic>> userMap = {
            for (var u in users)
              safeString(u.data() as Map<String, dynamic>, "userid"):
                  u.data() as Map<String, dynamic>
          };

          // Trigger popups for new jobs
          for (var jobDoc in jobs) {
            final jobData = jobDoc.data() as Map<String, dynamic>?;

            final String jobId = jobDoc.id;
            final String status = safeString(jobData, "status", "N/A");
            final String category = safeString(jobData, "category", "N/A");

            if (status == "open" && !_seenJobIdsForPopup.contains(jobId)) {
              _showJobNotification(jobId, category);
            }
          }

          var postedby;
          for (var u in users) {
            if (u["userid"] == jobs[1]["userid"]) {
              postedby = u.id;
            }
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              print('this is the post $postedby');

              final jobData = jobs[index].data() as Map<String, dynamic>?;

              final String userId = safeString(jobData, "userid", "");
              final userData = userMap[userId];

              final String category = safeString(jobData, "category", "N/A");
              final String status = safeString(jobData, "status", "N/A");

              final String name = safeString(userData, "name", "Unknown User");
              final String number = safeString(userData, "Phone_number", "N/A");
              final String address = safeString(userData, "adress", "N/A");

              return Card(
                margin: const EdgeInsets.only(bottom: 15),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Category: $category",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Status: $status",
                          style: const TextStyle(color: Colors.blue)),
                      const SizedBox(height: 10),
                      Text("Client Name: $name"),
                      Text("Client Number: $number"),
                      Text("Address: $address"),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () =>
                                _firestore.acceptJob(jobs[index].id),
                            child: const Text("Accept"),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () =>
                                _firestore.rejectJob(jobs[index].id),
                            child: const Text("Reject"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                          ),
                        ],
                      ),
                    ],
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

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:mistri_app/components/workAccept_card.dart';
// import 'package:mistri_app/firebase_services/firestore.dart';
// import 'package:mistri_app/screens/login_screen.dart';

// class WorkerDashboard extends StatefulWidget {
//   const WorkerDashboard({super.key});

//   @override
//   State<WorkerDashboard> createState() => _WorkerDashboardState();
// }

// class _WorkerDashboardState extends State<WorkerDashboard> {
//   final Firestore _firestore = Firestore();
//   final Set<String> _seenJobIdsForPopup = Set<String>();

//   void _showJobNotification(String jobId, String category) {
//     if (_seenJobIdsForPopup.contains(jobId)) return;
//     _seenJobIdsForPopup.add(jobId);

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => JobNotificationDialog(
//           jobId: jobId,
//           category: category,
//           firestoreService: _firestore,
//           onTimeout: () {
//             if (Navigator.of(context).canPop()) {
//               Navigator.of(context).pop();
//             }
//             // Optional: Mark job as missed here
//           },
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Worker Dashboard"),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: IconButton(
//                 onPressed: () {
//                   FirebaseAuth.instance.signOut();
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => LoginScreen(),
//                     ),
//                   );
//                 },
//                 icon: Icon(
//                   Icons.logout,
//                 )),
//           )
//         ],
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _firestore.getJob(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             print("Firestore Error: ${snapshot.error}"); // Log the error
//             return Center(child: Text('Something went wrong'));
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           // Use a final variable for clarity
//           final List<DocumentSnapshot> jobs = snapshot.data!.docs;

//           // LOGIC TO DETECT NEW JOBS SAFELY
//           for (var jobDoc in jobs) {
//             // Cast data safely to a Map first
//             final data = jobDoc.data() as Map<String, dynamic>?;

//             if (data != null) {
//               final String jobId = jobDoc.id;
//               // Safely access fields, defaulting to 'unknown' or 'N/A' if missing
//               final String status = data['status'] ?? 'unknown';
//               final String jobCategory = data['category'] ?? 'N/A';

//               if (status == 'pending' && !_seenJobIdsForPopup.contains(jobId)) {
//                 _showJobNotification(jobId, jobCategory);
//               }
//             }
//           }
//           // END LOGIC

//           return ListView.builder(
//             itemCount: jobs.length,
//             itemBuilder: (BuildContext context, int index) {
//               var job = jobs[index];
//               // Safely access data for the ListView display
//               final jobData = job.data() as Map<String, dynamic>?;

//               if (jobData == null)
//                 return SizedBox.shrink(); // Skip if data is null

//               final String status = jobData['status'] ?? 'unknown';
//               final String category = jobData['category'] ?? 'N/A';

//               return Container(
//                 child: Column(
//                   children: [
//                     Text(
//                       category,
//                     ),
//                     Text(status),
//                     ElevatedButton(
//                         onPressed: () {
//                           _firestore.acceptJob(job.id);
//                         },
//                         child: Text('accept'))
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
