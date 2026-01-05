import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mistri_app/firebase_services/firestore.dart';
import 'package:rxdart/rxdart.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final Firestore _firestore = Firestore();

  Stream<List<dynamic>> _combinedStream() {
    return Rx.combineLatest2(
      _firestore.notifyJob(),
      _firestore.getWorker(),
      (jobs, workers) => [jobs, workers],
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final String userId = currentUser?.uid ?? 'No user signed in';

    int flag = 0;

    return SafeArea(
      child: StreamBuilder(
        stream: _combinedStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final jobSnap = snapshot.data![0];
          final workerSnap = snapshot.data![1];

          final jobs = jobSnap.docs;
          final workers = workerSnap.docs;

          if (jobs.isEmpty) {
            return const Center(child: Text("No one accepted yet"));
          }

          // Convert workers list -> Map for O(1) lookup
          final Map<String, dynamic> workerMap = {
            for (var w in workers) w.data()["worker_id"]: w.data()
          };

          final Map<String, dynamic> jobMap = {
            for (var j in jobs) j.data()["userid"]: j.data()
          };

          for (var j in jobMap.entries) {
            if (j.value["userid"] == userId &&
                j.value["status"] == "accepted") {
              // User has an accepted job
              // You can set a flag or perform any action here
              flag = 1;
            }
          }

          if (flag == 1) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                final job = jobs[index].data() as Map<String, dynamic>;

                final String? acceptedBy = job["workerid"];

                // Safe lookup (no errors)
                final workerData = workerMap[acceptedBy];

                final workerName =
                    workerData != null ? workerData["name"] : "Unknown worker";

                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: job['userid'] == userId
                      ? ListTile(
                          title: Text("Category: ${job['category']}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Status: ${job['status']}"),
                              Text("Accepted by: $workerName"),
                              Text(
                                  'Phone number : ${workerData['Phone_number']}')
                            ],
                          ),
                        )
                      : null,
                );
              },
            );
          } else {
            return const Center(child: Text("No one accepted yet"));
          }
        },
      ),
    );
  }
}
