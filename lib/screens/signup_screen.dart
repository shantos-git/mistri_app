// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mistri_app/components/my_button.dart';
// import 'package:mistri_app/components/my_textfield.dart';
// import 'package:mistri_app/firebase_services/firestore.dart';
// import 'package:mistri_app/models/universal_model.dart';
// import 'package:mistri_app/models/client.dart';
// import 'package:mistri_app/screens/home_screen.dart';
// import 'package:mistri_app/screens/user_map_screen.dart';
// import 'package:provider/provider.dart';

// class SignupScreen extends StatefulWidget {
//   SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   String? selectedArea;

//   TextEditingController name = TextEditingController();

//   TextEditingController username = TextEditingController();

//   TextEditingController adress = TextEditingController();

//   TextEditingController gender = TextEditingController();

//   TextEditingController date_of_birth = TextEditingController();

//   Firestore _firestore = Firestore();

//   @override
//   Widget build(BuildContext context) {
//     final number = Provider.of<UniversalModel>(context).phone_number;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: SizedBox.expand(
//           // height: double.infinity,
//           // width: double.infinity,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Center(
//                   child: Image.asset(
//                     'assets/images/logo.png',
//                     height: 60,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 40,
//                   ),
//                   child: Row(
//                     children: [
//                       Text(
//                         'Update Your Account',
//                         style: TextStyle(
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 40,
//                   ),
//                   child: Text(
//                     'Best place to find local service',
//                     style: TextStyle(
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 40,
//                         vertical: 10,
//                       ),
//                       child: Text(
//                         'Full Name',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     MyTextfield(
//                       isPassword: false,
//                       hinttxt: 'Ex: John Doe',
//                       controller: name,
//                     ),
//                   ],
//                 ),
//                 // Column(
//                 //   crossAxisAlignment: CrossAxisAlignment.start,
//                 //   children: [
//                 //     Padding(
//                 //       padding: const EdgeInsets.symmetric(
//                 //         horizontal: 40,
//                 //         vertical: 10,
//                 //       ),
//                 //       child: Text(
//                 //         'Phone number',
//                 //         style: TextStyle(
//                 //           color: Colors.black,
//                 //           fontWeight: FontWeight.bold,
//                 //         ),
//                 //       ),
//                 //     ),
//                 //     // PhoneNumberBox(),
//                 //   ],
//                 // ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 40,
//                       ),
//                       child: Text(
//                         'Username',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     MyTextfield(
//                       isPassword: false,
//                       hinttxt: 'Enter user name',
//                       controller: username,
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 35.0),
//                   child: const Text("Area",
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//                 ),
//                 const SizedBox(height: 6),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 35.0),
//                   child: Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: Colors.grey.shade300),
//                     ),
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton<String>(
//                         hint: const Text("Select Area"),
//                         value: selectedArea,
//                         items: [
//                           'Mirpur',
//                           'Dhanmondi',
//                           'Bosundhora',
//                           'Banani',
//                           'Gulsan',
//                           'Mohakhali',
//                           'Mohhamadpur',
//                         ]
//                             .map((v) =>
//                                 DropdownMenuItem(value: v, child: Text(v)))
//                             .toList(),
//                         onChanged: (v) => setState(() => selectedArea = v),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Column(
//                 //   crossAxisAlignment: CrossAxisAlignment.start,
//                 //   children: [
//                 //     Padding(
//                 //       padding: const EdgeInsets.symmetric(
//                 //         horizontal: 40,
//                 //         vertical: 10,
//                 //       ),
//                 //       child: Text(
//                 //         'Adress',
//                 //         style: TextStyle(
//                 //           color: Colors.black,
//                 //           fontWeight: FontWeight.bold,
//                 //         ),
//                 //       ),
//                 //     ),
//                 //     MyTextfield(
//                 //       isPassword: false,
//                 //       hinttxt: 'Enter your adress',
//                 //       controller: adress,
//                 //     ),
//                 //   ],
//                 // ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 40,
//                         vertical: 10,
//                       ),
//                       child: Text(
//                         'Gender',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     MyTextfield(
//                       isPassword: false,
//                       hinttxt: 'Enter your gender',
//                       controller: gender,
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 40,
//                         vertical: 10,
//                       ),
//                       child: Text(
//                         'Date of Birth',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     MyTextfield(
//                       isPassword: false,
//                       hinttxt: 'Enter your date of birth',
//                       controller: date_of_birth,
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 37,
//                         vertical: 20,
//                       ),
//                       child: MyButton(
//                         btntxt: 'CREATE ACCOUNT',
//                         onClick: () {
//                           Client newUser = Client(
//                             name: name.text,
//                             userName: username.text,
//                             adress: selectedArea.toString(),
//                             gender: gender.text,
//                             date_of_birth: date_of_birth.text,
//                             phnNumber: number,
//                             userId: FirebaseAuth.instance.currentUser!.uid,
//                             latitude: 0, //result['lat'],
//                             longitude: 0, //result['lng'],
//                           );

//                           _firestore.addUser(newUser);

//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => HomeScreen(),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 // SigninBox(),
//                 // Padding(
//                 //   padding: const EdgeInsets.only(bottom: 20),
//                 //   child: GestureDetector(
//                 //     child: Row(
//                 //       mainAxisAlignment: MainAxisAlignment.center,
//                 //       children: [
//                 //         Text(
//                 //           'Already Have an account?',
//                 //           style: TextStyle(
//                 //             color: Colors.grey,
//                 //           ),
//                 //         ),
//                 //         // GestureDetector(
//                 //         //   onTap: () {
//                 //         //     Navigator.push(
//                 //         //       context,
//                 //         //       MaterialPageRoute(
//                 //         //         builder: (context) => LoginScreen(),
//                 //         //       ),
//                 //         //     );
//                 //         //   },
//                 //         //   child: Text(
//                 //         //     'Login',
//                 //         //     style: TextStyle(
//                 //         //         color: const Color.fromARGB(255, 34, 137, 220)),
//                 //         //   ),
//                 //         // ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mistri_app/components/my_button.dart';
import 'package:mistri_app/components/my_textfield.dart';
import 'package:mistri_app/firebase_services/firestore.dart';
import 'package:mistri_app/models/client.dart';
import 'package:mistri_app/screens/home_screen.dart';
import 'package:mistri_app/screens/user_map_screen.dart';
import 'package:provider/provider.dart';
import 'package:mistri_app/models/universal_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController dateOfBirth = TextEditingController();

  final Firestore _firestore = Firestore();

  // 🔹 Location
  double? latitude;
  double? longitude;
  String? address;

  String? selectedArea;

  @override
  Widget build(BuildContext context) {
    final number = Provider.of<UniversalModel>(context).phone_number;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset('assets/images/logo.png', height: 60),
              const SizedBox(height: 20),
              const Text(
                'Update Your Account',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Name
              MyTextfield(
                isPassword: false,
                hinttxt: 'Full Name',
                controller: name,
              ),

              const SizedBox(height: 10),
              // Username
              MyTextfield(
                isPassword: false,
                hinttxt: 'Username',
                controller: username,
              ),

              const SizedBox(height: 10),
              // Dropdown Area
              DropdownButton<String>(
                hint: const Text("Select Area"),
                value: selectedArea,
                items: [
                  'Mirpur',
                  'Dhanmondi',
                  'Bosundhora',
                  'Banani',
                  'Gulsan',
                  'Mohakhali',
                  'Mohammadpur',
                ]
                    .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                    .toList(),
                onChanged: (v) => setState(() => selectedArea = v),
              ),

              const SizedBox(height: 20),
              // Gender
              MyTextfield(
                isPassword: false,
                hinttxt: 'Gender',
                controller: gender,
              ),

              const SizedBox(height: 10),
              // DOB
              MyTextfield(
                isPassword: false,
                hinttxt: 'Date of Birth',
                controller: dateOfBirth,
              ),

              const SizedBox(height: 20),
              // 🔹 PICK LOCATION
              MyButton(
                btntxt: address == null ? "Pick Location" : "Location Selected",
                onClick: () async {
                  // Open map screen
                  final Map<String, dynamic>? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const UserLocationMap(),
                    ),
                  );

                  if (result == null) return;

                  setState(() {
                    latitude = result['lat'];
                    longitude = result['lng'];
                    address = result['address'];
                  });
                },
              ),

              if (address != null)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    address!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                ),

              const SizedBox(height: 20),
              // 🔹 CREATE ACCOUNT
              MyButton(
                btntxt: 'CREATE ACCOUNT',
                onClick: () async {
                  final user = FirebaseAuth.instance.currentUser;

                  if (user == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("User not logged in")),
                    );
                    return;
                  }

                  if (latitude == null ||
                      longitude == null ||
                      address == null ||
                      name.text.isEmpty ||
                      username.text.isEmpty ||
                      gender.text.isEmpty ||
                      dateOfBirth.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              "Please fill all fields and select location")),
                    );
                    return;
                  }

                  try {
                    // Create Client object
                    Client newUser = Client(
                      name: name.text.trim(),
                      userName: username.text.trim(),
                      adress: address!,
                      gender: gender.text.trim(),
                      date_of_birth: dateOfBirth.text.trim(),
                      phnNumber: number,
                      userId: user.uid,
                      latitude: latitude!,
                      longitude: longitude!,
                    );

                    // Debug print
                    print("Saving user: ${newUser.user_tomap()}");

                    // Save to Firestore
                    await _firestore.addUser(newUser);

                    // Navigate to HomeScreen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => HomeScreen()),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Failed to save user: $e")),
                    );
                  }
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
