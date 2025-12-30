class Worker {
  String worktype;
  String name;
  String username;
  String number;
  String adress;
  String area;
  String workerId;

  Worker({
    required this.worktype,
    required this.name,
    required this.username,
    required this.number,
    required this.adress,
    required this.area,
    required this.workerId,
  });

  Map<String, dynamic> user_tomap() {
    return {
      "name": name,
      "username": username,
      "adress": adress,
      "category": worktype,
      "area": area,
      "Phone_number": number,
      "timeStamp": DateTime.now(),
      'worker_id': workerId,
    };
  }
}
