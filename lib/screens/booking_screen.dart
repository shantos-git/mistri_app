import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mistri_app/firebase_services/firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

  /// bKash sandbox bottom sheet
  void _openBkashPayment({
    required String jobId,
    required dynamic amount,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        final controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(
            Uri.parse(
              //bKash SANDBOX DEMO PAGE
              "https://merchantdemo.sandbox.bka.sh/payment",
            ),
          );

        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.95,
          child: Column(
            children: [
              AppBar(
                title: const Text("bKash Payment"),
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                color: Colors.red.shade50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Job ID: $jobId"),
                    Text("Amount: ৳$amount"),
                  ],
                ),
              ),
              const Divider(height: 0),
              Expanded(
                child: WebViewWidget(controller: controller),
              ),
            ],
          ),
        );
      },
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

          final Map<String, dynamic> workerMap = {
            for (var w in workers) w.data()["worker_id"]: w.data()
          };

          final Map<String, dynamic> jobMap = {
            for (var j in jobs) j.data()["userid"]: j.data()
          };

          for (var j in jobMap.entries) {
            if (j.value["userid"] == userId &&
                j.value["status"] == "accepted") {
              flag = 1;
            }
          }

          if (flag == 1) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                final job = jobs[index].data() as Map<String, dynamic>;

                if (job['userid'] != userId || job['status'] != 'accepted') {
                  return const SizedBox.shrink();
                }

                final String? acceptedBy = job["workerid"];
                final workerData = workerMap[acceptedBy];

                final workerName =
                    workerData != null ? workerData["name"] : "Unknown worker";

                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Category: ${job['category']}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text("Status: ${job['status']}"),
                        Text("Accepted by: $workerName"),
                        Text(
                          "Phone number: ${workerData?['Phone_number'] ?? 'N/A'}",
                        ),
                        const SizedBox(height: 12),

                        // PAYMENT BUTTON (PER CARD)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.payment),
                            label: const Text("Pay with bKash"),
                            onPressed: () {
                              _openBkashPayment(
                                jobId: job['name'] ?? 'unknown',
                                amount: job['bill'] ?? 500,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
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
