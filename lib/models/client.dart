import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  String name;
  String userName;
  String adress;
  String gender;
  String date_of_birth;
  String phnNumber;
  Timestamp time;
  String userId;

  // 🔹 NEW FIELDS
  double latitude;
  double longitude;

  Client({
    required this.name,
    required this.userName,
    required this.adress,
    required this.gender,
    required this.date_of_birth,
    required this.phnNumber,
    required this.userId,
    required this.latitude,
    required this.longitude,
    Timestamp? time,
  }) : time = time ?? Timestamp.now();

  Map<String, dynamic> user_tomap() {
    return {
      "name": name,
      "username": userName,
      "adress": adress,
      "gender": gender,
      "date_of_birth": date_of_birth,
      "Phone_number": phnNumber,
      "timeStamp": time,
      "userid": userId,

      // 🔹 LOCATION DATA
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}
