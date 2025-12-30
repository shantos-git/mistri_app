import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mistri_app/firebase_services/firestore.dart';
import 'package:mistri_app/models/worker.dart';
import 'package:mistri_app/screens/worker_dashboard.dart';

class PhotoScreen extends StatefulWidget {
  String type;
  String name;
  String number;
  String Adress;
  String area;

  PhotoScreen({
    required this.type,
    required this.name,
    required this.number,
    required this.Adress,
    required this.area,
  });
  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  File? nidFront;
  File? nidBack;
  File? selfie;

  Firestore _firestore = Firestore();

  bool loading = false;

  final picker = ImagePicker();

  Future<File?> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) return File(picked.path);
    return null;
  }

  Future<String> uploadToStorage(File file, String folder) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final ref = FirebaseStorage.instance.ref().child(
        "users/$uid/$folder/${DateTime.now().millisecondsSinceEpoch}.jpg");

    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  Future<void> uploadAllImages() async {
    setState(() => loading = true);

    final uid = FirebaseAuth.instance.currentUser!.uid;

    String frontUrl = await uploadToStorage(nidFront!, "nid_front");
    String backUrl = await uploadToStorage(nidBack!, "nid_back");
    String selfieUrl = await uploadToStorage(selfie!, "selfie");

    await FirebaseFirestore.instance.collection("users").doc(uid).set({
      "nid_front": frontUrl,
      "nid_back": backUrl,
      "selfie": selfieUrl,
      "step": 2,
    }, SetOptions(merge: true));

    setState(() => loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Images uploaded successfully")),
    );

    // Navigate next
  }

  Widget imageBox({
    required String label,
    required File? imageFile,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        SizedBox(height: 10),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: imageFile == null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt, size: 40, color: Colors.grey),
                        SizedBox(height: 6),
                        Text("Click a photo of the $label",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(imageFile,
                        fit: BoxFit.cover, width: double.infinity),
                  ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  "Register now",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),

                // NID Front
                imageBox(
                  label: "NID Card Front",
                  imageFile: nidFront,
                  onTap: () async {
                    File? img = await pickImage();
                    if (img != null) setState(() => nidFront = img);
                  },
                ),

                // NID Back
                imageBox(
                  label: "NID Card Back",
                  imageFile: nidBack,
                  onTap: () async {
                    File? img = await pickImage();
                    if (img != null) setState(() => nidBack = img);
                  },
                ),

                // Selfie
                imageBox(
                  label: "Selfie",
                  imageFile: selfie,
                  onTap: () async {
                    File? img = await pickImage();
                    if (img != null) setState(() => selfie = img);
                  },
                ),

                SizedBox(height: 20),

                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: (nidFront != null &&
                            nidBack != null &&
                            selfie != null &&
                            !loading)
                        ? () {
                            Worker newWorker = Worker(
                              worktype: widget.type,
                              name: widget.name,
                              username: Random().toString(),
                              number: widget.number,
                              adress: widget.Adress,
                              area: widget.area,
                              workerId: FirebaseAuth.instance.currentUser!.uid,
                            );

                            _firestore.addWorker(newWorker);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorkerDashboard(),
                              ),
                            );
                          }
                        : null,
                    child: loading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text("Confirm", style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
