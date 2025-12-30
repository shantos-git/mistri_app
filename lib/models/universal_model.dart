import 'package:flutter/material.dart';

class UniversalModel extends ChangeNotifier {
  String _phone_number = '';

  String get phone_number => _phone_number;

  void setNumber(String number) {
    _phone_number = number;
    notifyListeners();
  }
}
