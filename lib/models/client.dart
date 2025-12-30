import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  String name;
  String userName;
  // String imagePath;
  String adress;
  String gender;
  String date_of_birth;
  String phnNumber;
  Timestamp time = Timestamp.now();
  String userId;

  Client({
    required this.name,
    required this.userName,
    // required this.imagePath,
    required this.adress,
    required this.gender,
    required this.date_of_birth,
    required this.phnNumber,
    required this.userId,
  });

  Map<String, dynamic> user_tomap() {
    return {
      "name": name,
      "username": userName,
      // "imagePath": imagePath,
      "adress": adress,
      "gender": gender,
      "date_of_birth": date_of_birth,
      "Phone_number": phnNumber,
      "timeStamp": time,
      'userid': userId,
    };
  }
}
