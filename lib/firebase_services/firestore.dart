import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mistri_app/models/Job.dart';
import 'package:mistri_app/models/client.dart';
import 'package:mistri_app/models/worker.dart';

class Firestore {
  CollectionReference usercollection =
      FirebaseFirestore.instance.collection('Users');
  CollectionReference job_postcollection =
      FirebaseFirestore.instance.collection('Job_Post');
  CollectionReference providercollection =
      FirebaseFirestore.instance.collection('Provider');

  //add user
  Future<void> addUser(Client newUser) {
    return usercollection
        .doc(
          newUser.user_tomap()["Phone_number"],
        )
        .set(newUser.user_tomap());
  }

  //add worker
  Future<void> addWorker(Worker newWorker) {
    return providercollection
        .doc(
          newWorker.user_tomap()["Phone_number"],
        )
        .set(newWorker.user_tomap());
  }

  //read user
  Stream<QuerySnapshot> getUser() {
    final users = usercollection.snapshots();

    return users;
  }

  //get the
  Stream<QuerySnapshot> getWorker() {
    final workers = providercollection.snapshots();

    return workers;
  }

  //add jobs
  // Future<void> addJob(Job newJob) {
  //   return job_postcollection.add(newJob.user_tomap());
  // }
  Future<Future<DocumentReference<Object?>>> addJob(Job newJob) async {
    // Convert the Job model to a map
    Map<String, dynamic> jobMap = newJob.user_tomap();

    // Explicitly add or overwrite the 'status' field to ensure it exists
    jobMap['status'] = 'open';

    return job_postcollection.add(jobMap);
  }

  //read jobs
  // Stream<QuerySnapshot> getJob() {
  //   final jobs = job_postcollection.snapshots();

  //   return jobs;
  // }

  Stream<QuerySnapshot> getJob() {
    final jobs =
        job_postcollection.where('status', isEqualTo: 'open').snapshots();
    return jobs;
  }

  Stream<QuerySnapshot> notifyJob() {
    final jobs =
        job_postcollection.where('status', isEqualTo: 'accepted').snapshots();
    return jobs;
  }

  //update user

  //delete user

  // Add function to accept the job (required by WorkerDashboard/Dialog)
  Future<void> acceptJob(String jobId) async {
    await job_postcollection.doc(jobId).update({
      'status': 'accepted',
      'workerid': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  // Add function to reject the job (required by WorkerDashboard/Dialog)
  Future<void> rejectJob(String jobId) async {
    await job_postcollection.doc(jobId).update({'status': 'rejected'});
  }
}
