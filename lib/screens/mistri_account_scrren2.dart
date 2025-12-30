import 'package:flutter/material.dart';
import 'package:mistri_app/components/my_button.dart';
import 'package:mistri_app/components/my_textfield.dart';
import 'package:mistri_app/models/universal_model.dart';
import 'package:mistri_app/screens/photo_screen.dart';
import 'package:provider/provider.dart';

class MistriAccountScrren2 extends StatefulWidget {
  MistriAccountScrren2({super.key});

  @override
  State<MistriAccountScrren2> createState() => _MistriAccountScrren2State();
}

class _MistriAccountScrren2State extends State<MistriAccountScrren2> {
  String? selectedService;
  String? selectedCity;
  String? selectedArea;
  TextEditingController nameController = TextEditingController();
  // TextEditingController mobileController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final number = Provider.of<UniversalModel>(context).phone_number;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'Register now',
                style: TextStyle(
                  color: const Color(0xFF292929),
                  fontSize: 40,
                  fontFamily: 'Onest',
                  fontWeight: FontWeight.w700,
                  height: 1.20,
                  letterSpacing: -1.60,
                ),
              ),
            ),
            SizedBox(
              height: 34,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: const Text("Service Type",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text("Select Type"),
                    value: selectedService,
                    items: [
                      'Electrician',
                      'plumber',
                      'Cleaner',
                    ]
                        .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                        .toList(),
                    onChanged: (v) => setState(() => selectedService = v),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 39,
              ),
              child: Text(
                'Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            MyTextfield(
                isPassword: false,
                hinttxt: 'Ex: Rakibul Islam Shanto',
                controller: nameController),
            SizedBox(
              height: 16,
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: 39,
            //   ),
            //   child: Text(
            //     'Mobile',
            //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            //   ),
            // ),
            // MyTextfield(
            //     isPassword: false,
            //     hinttxt: '01XXXXXXXXX',
            //     controller: mobileController),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 39,
              ),
              child: Text(
                'Adress',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            MyTextfield(
                isPassword: false,
                hinttxt: 'Ex: Mirpur',
                controller: adressController),
            SizedBox(
              height: 10,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 35.0),
            //   child: const Text("City",
            //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            // ),
            // const SizedBox(height: 6),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 35.0),
            //   child: Container(
            //     width: double.infinity,
            //     padding: const EdgeInsets.symmetric(horizontal: 12),
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(10),
            //       border: Border.all(color: Colors.grey.shade300),
            //     ),
            //     child: DropdownButtonHideUnderline(
            //       child: DropdownButton<String>(
            //         hint: const Text("Select City"),
            //         value: selectedCity,
            //         items: [
            //           'Dhaka',
            //           'Bogura',
            //           'Chittagong',
            //           'Rajshahi',
            //           'Rongpur',
            //         ]
            //             .map((v) => DropdownMenuItem(value: v, child: Text(v)))
            //             .toList(),
            //         onChanged: (v) => setState(() => selectedCity = v),
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: const Text("Area",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text("Select Area"),
                    value: selectedArea,
                    items: [
                      'Mirpur',
                      'Dhanmondi',
                      'Bosundhora',
                      'Banani',
                      'Gulsan',
                      'Mohakhali',
                      'Mohhamadpur',
                    ]
                        .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                        .toList(),
                    onChanged: (v) => setState(() => selectedArea = v),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: MyButton(
                  btntxt: 'Next Step',
                  onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhotoScreen(
                          type: selectedService.toString(),
                          Adress: adressController.text,
                          area: selectedArea.toString(),
                          name: nameController.text,
                          number: number,
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
