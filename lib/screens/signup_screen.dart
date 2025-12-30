import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mistri_app/components/my_button.dart';
import 'package:mistri_app/components/my_textfield.dart';
import 'package:mistri_app/firebase_services/firestore.dart';
import 'package:mistri_app/models/universal_model.dart';
import 'package:mistri_app/models/client.dart';
import 'package:mistri_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? selectedArea;

  TextEditingController name = TextEditingController();

  TextEditingController username = TextEditingController();

  TextEditingController adress = TextEditingController();

  TextEditingController gender = TextEditingController();

  TextEditingController date_of_birth = TextEditingController();

  Firestore _firestore = Firestore();

  @override
  Widget build(BuildContext context) {
    final number = Provider.of<UniversalModel>(context).phone_number;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox.expand(
          // height: double.infinity,
          // width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 60,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Update Your Account',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: Text(
                    'Best place to find local service',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 10,
                      ),
                      child: Text(
                        'Full Name',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    MyTextfield(
                      isPassword: false,
                      hinttxt: 'Ex: John Doe',
                      controller: name,
                    ),
                  ],
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.symmetric(
                //         horizontal: 40,
                //         vertical: 10,
                //       ),
                //       child: Text(
                //         'Phone number',
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //     // PhoneNumberBox(),
                //   ],
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                      ),
                      child: Text(
                        'Username',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    MyTextfield(
                      isPassword: false,
                      hinttxt: 'Enter user name',
                      controller: username,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: const Text("Area",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
                            .map((v) =>
                                DropdownMenuItem(value: v, child: Text(v)))
                            .toList(),
                        onChanged: (v) => setState(() => selectedArea = v),
                      ),
                    ),
                  ),
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.symmetric(
                //         horizontal: 40,
                //         vertical: 10,
                //       ),
                //       child: Text(
                //         'Adress',
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //     MyTextfield(
                //       isPassword: false,
                //       hinttxt: 'Enter your adress',
                //       controller: adress,
                //     ),
                //   ],
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 10,
                      ),
                      child: Text(
                        'Gender',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    MyTextfield(
                      isPassword: false,
                      hinttxt: 'Enter your gender',
                      controller: gender,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 10,
                      ),
                      child: Text(
                        'Date of Birth',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    MyTextfield(
                      isPassword: false,
                      hinttxt: 'Enter your date of birth',
                      controller: date_of_birth,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 37,
                        vertical: 20,
                      ),
                      child: MyButton(
                        btntxt: 'CREATE ACCOUNT',
                        onClick: () {
                          Client newUser = Client(
                            name: name.text,
                            userName: username.text,
                            adress: selectedArea.toString(),
                            gender: gender.text,
                            date_of_birth: date_of_birth.text,
                            phnNumber: number,
                            userId: FirebaseAuth.instance.currentUser!.uid,
                          );

                          _firestore.addUser(newUser);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                // SigninBox(),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 20),
                //   child: GestureDetector(
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Text(
                //           'Already Have an account?',
                //           style: TextStyle(
                //             color: Colors.grey,
                //           ),
                //         ),
                //         // GestureDetector(
                //         //   onTap: () {
                //         //     Navigator.push(
                //         //       context,
                //         //       MaterialPageRoute(
                //         //         builder: (context) => LoginScreen(),
                //         //       ),
                //         //     );
                //         //   },
                //         //   child: Text(
                //         //     'Login',
                //         //     style: TextStyle(
                //         //         color: const Color.fromARGB(255, 34, 137, 220)),
                //         //   ),
                //         // ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
