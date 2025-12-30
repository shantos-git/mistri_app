import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mistri_app/components/my_button.dart';
import 'package:mistri_app/components/phnnum_box.dart';
import 'package:mistri_app/models/universal_model.dart';
import 'package:mistri_app/screens/otpverification_screen.dart';
import 'package:provider/provider.dart';

// Change from StatelessWidget to StatefulWidget
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController numberController = TextEditingController();

  // Variable to store the Firebase token needed for resending (managed here temporarily)
  int? _resendToken;

  // Centralized function to handle the phone verification API call
  void _verifyPhoneNumber({int? forceResendingToken}) {
    // Standard phone number format for Firebase Auth (hardcoded +880 based on original code)
    final String phoneNumber = '+880${numberController.text}';
    Provider.of<UniversalModel>(context, listen: false).setNumber(phoneNumber);

    // Show a loading indicator if needed before making the call
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sending OTP...")));

    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // This usually happens on Android when the SMS is automatically read.
        // You sign the user in immediately and navigate home.
        await FirebaseAuth.instance.signInWithCredential(credential);
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      },
      verificationFailed: (FirebaseAuthException ex) {
        // Handle network errors, invalid phone numbers, or quota limits
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Verification Failed: ${ex.message}")),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        // Store the token received from Firebase in the state variable
        setState(() {
          _resendToken = resendToken;
        });

        // Navigate to the OTP screen, passing the verificationId AND the resendToken
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpverificationScreen(
              vid: verificationId,

              resendToken: _resendToken, // Pass the token along
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String vid) {
        // Called when the automatic SMS code retrieval times out on Android
      },
      // When this function is called from the resend button in the OTP screen,
      // the token is passed here to force a new SMS send.
      forceResendingToken: forceResendingToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    UniversalModel data = UniversalModel();
    data.setNumber(
      numberController.toString(),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 40, bottom: 15),
                  child: Image.asset('assets/images/logo.png', height: 60),
                ),
                SizedBox(height: 30),
                // ... (Rest of Welcome Text UI) ...
                SizedBox(height: 150),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: Text('Phone number',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    PhoneNumberBox(controller: numberController),
                  ],
                ),
                SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: MyButton(
                        btntxt: 'Send OTP',
                        // Call the centralized function for the initial send
                        onClick: () => _verifyPhoneNumber(),
                      ),
                    ),
                  ],
                ),
                // ... (Rest of UI for SigninBox, Register link) ...
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mistri_app/components/my_button.dart';
// import 'package:mistri_app/components/my_textfield.dart';
// import 'package:mistri_app/components/phnnum_box.dart';
// import 'package:mistri_app/components/signin_box.dart';
// import 'package:mistri_app/screens/otpverification_screen.dart';
// import 'package:mistri_app/screens/resetpass_screen.dart';
// import 'package:mistri_app/screens/signup_screen.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController numberController = TextEditingController();

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: SizedBox(
//           height: double.infinity,
//           width: double.infinity,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               // mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     top: 20,
//                     left: 40,
//                     bottom: 15,
//                   ),
//                   child: Image.asset(
//                     'assets/images/logo.png',
//                     height: 60,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 40,
//                   ),
//                   child: Row(
//                     children: [
//                       Text(
//                         'Welcome to ',
//                         style: TextStyle(
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         'Mistri',
//                         style: TextStyle(
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                           color: const Color.fromARGB(255, 39, 149, 240),
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
//                     'Labor Service, Anytime, Anywhere',
//                     style: TextStyle(
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 150,
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
//                         'Phone number',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     PhoneNumberBox(
//                       controller: numberController,
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
//                 //         'Password',
//                 //         style: TextStyle(
//                 //           color: Colors.black,
//                 //           fontWeight: FontWeight.bold,
//                 //         ),
//                 //       ),
//                 //     ),
//                 //     MyTextfield(
//                 //       isPassword: true,
//                 //       hinttxt: 'Enter your password',
//                 //     ),
//                 //   ],
//                 // ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 30,
//                       ),
//                       child: MyButton(
//                         btntxt: 'Send OTP',
//                         onClick: () async {
//                           FirebaseAuth.instance.verifyPhoneNumber(
//                             verificationCompleted:
//                                 (PhoneAuthCredential credential) {},
//                             verificationFailed: (FirebaseAuthException ex) {},
//                             codeSent: (String vid, int? resenttoken) {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => OtpverificationScreen(
//                                     vid: vid,
//                                     phn_number: "+880${numberController.text}",
//                                   ),
//                                 ),
//                               );
//                             },
//                             codeAutoRetrievalTimeout: (String vid) {},
//                             phoneNumber: '+880${numberController.text}',
//                           );
//                         },
//                       ),
//                     ),
//                     // Padding(
//                     //   padding: const EdgeInsets.symmetric(horizontal: 40),
//                     //   child: GestureDetector(
//                     //     onTap: () {
//                     //       Navigator.push(
//                     //         context,
//                     //         MaterialPageRoute(
//                     //           builder: (context) => ResetpassScreen(),
//                     //         ),
//                     //       );
//                     //     },
//                     //     child: Text(
//                     //       'Forgotten Password?',
//                     //       style: TextStyle(
//                     //           color: const Color.fromARGB(255, 34, 137, 220)),
//                     //     ),
//                     //   ),
//                     // )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 // SigninBox(),
//                 // Padding(
//                 //   padding: const EdgeInsets.only(
//                 //     bottom: 40,
//                 //   ),
//                 //   child: Row(
//                 //     mainAxisAlignment: MainAxisAlignment.center,
//                 //     children: [
//                 //       Text(
//                 //         'Not a member?',
//                 //         style: TextStyle(
//                 //           color: Colors.grey,
//                 //         ),
//                 //       ),
//                 //       GestureDetector(
//                 //         onTap: () {
//                 //           Navigator.push(
//                 //             context,
//                 //             MaterialPageRoute(
//                 //               builder: (context) => SignupScreen(),
//                 //             ),
//                 //           );
//                 //         },
//                 //         child: Text(
//                 //           ' Register',
//                 //           style: TextStyle(color: Colors.blue),
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
