import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNumberBox extends StatefulWidget {
  TextEditingController controller;
  PhoneNumberBox({
    super.key,
    required this.controller,
  });

  @override
  State<PhoneNumberBox> createState() => _PhoneNumberBoxState();
}

class _PhoneNumberBoxState extends State<PhoneNumberBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
      ),
      child: IntlPhoneField(
        controller: widget.controller,
        showCountryFlag: false,
        showDropdownIcon: false,
        initialCountryCode: 'BD',
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: '1XXXXXXXXX',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
