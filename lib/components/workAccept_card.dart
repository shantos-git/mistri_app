import 'dart:async';
import 'package:flutter/material.dart';
// Make sure this import path is correct for your project
import 'package:mistri_app/firebase_services/firestore.dart';

class JobNotificationDialog extends StatefulWidget {
  final String jobId;
  final String category;
  final Firestore firestoreService;
  final Function onTimeout;

  const JobNotificationDialog({
    Key? key,
    required this.jobId,
    required this.category,
    required this.firestoreService,
    required this.onTimeout,
  }) : super(key: key);

  @override
  _JobNotificationDialogState createState() => _JobNotificationDialogState();
}

class _JobNotificationDialogState extends State<JobNotificationDialog> {
  int _secondsRemaining = 30; // 30 seconds limit for the worker to respond
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
        // Call the timeout function provided by the dashboard
        widget.onTimeout();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer
        ?.cancel(); // Important: Cancel the timer when the dialog is dismissed
    super.dispose();
  }

  void _accept() {
    // widget.firestoreService.acceptJob(widget.jobId); // Update Firestore status
    Navigator.of(context).pop(); // Dismiss the dialog
  }

  void _reject() {
    // widget.firestoreService.rejectJob(widget.jobId); // Update Firestore status
    Navigator.of(context).pop(); // Dismiss the dialog
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // Position the dialog at the top of the screen
      alignment: Alignment.topCenter,
      // Remove default padding so it spans the width
      insetPadding: EdgeInsets.zero,
      child: Container(
        // Add padding below the phone's status bar
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New Job Alert!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '$_secondsRemaining s',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Category: ${widget.category}'),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _reject,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Reject'),
                ),
                ElevatedButton(
                  onPressed: _accept,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text('Accept'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
