class Job {
  String userid;
  String username;
  String workerid;
  String category;
  String description;
  String paymentMethod;
  String phnNumber;
  String bill;
  String postTime;

  Job({
    required this.userid,
    required this.username,
    required this.workerid,
    required this.category,
    required this.description,
    required this.paymentMethod,
    required this.bill,
    required this.postTime,
    required this.phnNumber,
  });

  Map<String, dynamic> user_tomap() {
    return {
      "userid": userid,
      'name': username,
      "workerid": workerid,
      "category": category,
      "description": description,
      "paymentMethod": paymentMethod,
      "bill": bill,
      "Phone_number": phnNumber,
      "timeStamp": postTime,
    };
  }
}
