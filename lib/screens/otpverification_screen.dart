import 'dart:async'; // Required for the Timer class

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// Make sure you have these custom components in your project
import 'package:mistri_app/components/my_button.dart';
import 'package:mistri_app/firebase_services/firestore.dart';
import 'package:mistri_app/models/universal_model.dart';
import 'package:mistri_app/models/worker.dart';
import 'package:mistri_app/screens/home_screen.dart';
import 'package:mistri_app/screens/signup_screen.dart';
import 'package:mistri_app/screens/worker_dashboard.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpverificationScreen extends StatefulWidget {
  final String vid;

  Firestore _firestore = Firestore();

  final int? resendToken;
  final String number = '';

  OtpverificationScreen({
    super.key,
    required this.vid,
    this.resendToken,
  });

  @override
  State<OtpverificationScreen> createState() => _OtpverificationScreenState();
}

class _OtpverificationScreenState extends State<OtpverificationScreen> {
  // Instantiate your Firestore service class
  final Firestore _firestore = Firestore();

  final TextEditingController otpController = TextEditingController();

  // Manage state for verification ID and token locally as they update on resend
  late String _currentVerificationId;
  int? _currentResendToken;

  // Timer related variables
  Timer? _timer;
  int _start = 30; // Cooldown period for resending
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _currentVerificationId = widget.vid;
    _currentResendToken = widget.resendToken;
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is removed
    otpController.dispose();
    super.dispose();
  }

  // Helper function to check Firestore if a user exists
  Future<bool> checkIfUserExists(String phoneNumber) async {
    try {
      // Get the first snapshot from the stream (a single fetch)
      // NOTE: Ensure your Firestore().getUser() method returns a Stream<QuerySnapshot>
      QuerySnapshot snapshot = await _firestore.getUser().first;

      // Check if any document ID matches the phone number
      bool exists = snapshot.docs.any((doc) => doc.id == phoneNumber);
      return exists;
    } catch (e) {
      print("Error checking user existence: $e");
      // Assume false or handle error appropriately if Firestore fails
      return false;
    }
  }

  // Function to start the countdown timer
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    // Reset state when starting the timer
    setState(() {
      _canResend = false;
      _start = 30;
    });

    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _canResend = true; // Enable the resend button after timeout
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  // Function to resend the OTP using the forceResendingToken
  void _resendOtp() {
    if (_currentResendToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Cannot resend without a valid token.')));
      return;
    }

    // Timer is reset within the startTimer function called below
    startTimer();

    final number = Provider.of<UniversalModel>(context, listen: false)
        .phone_number; // This handles the state updates for `_canResend` and `_start`

    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException ex) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to resend OTP: ${ex.message}')),
        );
        setState(() {
          _canResend = true;
          _timer?.cancel();
        });
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _currentVerificationId = verificationId;
          _currentResendToken = resendToken;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('New OTP sent successfully!')),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      forceResendingToken: _currentResendToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    final number =
        Provider.of<UniversalModel>(context, listen: false).phone_number;
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.getWorker(),
              builder: (context, snapshot) {
                final List<DocumentSnapshot> workers = snapshot.data!.docs;
                return SizedBox.expand(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // ... (Image and Title UI code maintained) ...
                        Image.asset('assets/images/otp.png', height: 128),
                        Column(
                          children: [
                            const Text(
                              'OTP Verfication',
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'One Time Password(OTP) has been sent to via SMS\n                             to ${number}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'Enter the OTP below to verify it',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            Pinput(
                              controller: otpController,
                              length: 6,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            MyButton(
                                btntxt: 'VERIFY OTP',
                                onClick: () async {
                                  try {
                                    // 1. Verify OTP
                                    PhoneAuthCredential credential =
                                        PhoneAuthProvider.credential(
                                      verificationId: _currentVerificationId,
                                      smsCode: otpController.text,
                                    );

                                    await FirebaseAuth.instance
                                        .signInWithCredential(credential);

                                    _timer?.cancel();

                                    // 2. Check if user exists in users collection
                                    bool userExists =
                                        await checkIfUserExists(number);

                                    if (!userExists) {
                                      // New user → go to signup
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignupScreen(),
                                        ),
                                      );
                                      return;
                                    }

                                    // 3. CHECK IF THIS USER IS A WORKER
                                    QuerySnapshot workerSnap =
                                        await _firestore.getWorker().first;

                                    bool isWorker = workerSnap.docs
                                        .any((doc) => doc.id == number);

                                    if (isWorker) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const WorkerDashboard(),
                                        ),
                                      );
                                    } else {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen(),
                                        ),
                                      );
                                    }
                                  } catch (ex) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Invalid OTP")),
                                    );
                                  }
                                }),
                            const SizedBox(height: 20),
                            // RESEND OTP UI INTEGRATION
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Didn't receive code?"),
                                TextButton(
                                  // The `onPressed` handler is null if `_canResend` is false (during countdown)
                                  onPressed: _canResend ? _resendOtp : null,
                                  child: Text(
                                    // Dynamically change text based on timer state
                                    _canResend
                                        ? "Resend"
                                        : "Resend in $_start s",
                                    style: TextStyle(
                                      color: _canResend
                                          ? Colors.blue
                                          : Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}

// import 'dart:async'; // Required for the Timer class

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mistri_app/components/my_button.dart';
// import 'package:mistri_app/firebase_services/firestore.dart';
// import 'package:mistri_app/screens/home_screen.dart';
// import 'package:mistri_app/screens/signup_screen.dart';
// import 'package:pinput/pinput.dart';

// class OtpverificationScreen extends StatefulWidget {
//   // Add an optional resendToken parameter to the constructor
//   final String vid;
//   final String phn_number;
//   final int? resendToken;

//   const OtpverificationScreen({
//     super.key,
//     required this.vid,
//     required this.phn_number,
//     this.resendToken, // Accept the token passed from LoginScreen
//   });

//   @override
//   State<OtpverificationScreen> createState() => _OtpverificationScreenState();
// }

// class _OtpverificationScreenState extends State<OtpverificationScreen> {
//   Firestore _firestore = Firestore();

//   bool _isThere = false;

//   final TextEditingController otpController = TextEditingController();

//   // Manage state for verification ID and token locally as they update on resend
//   late String _currentVerificationId;
//   int? _currentResendToken;

//   // Timer related variables
//   Timer? _timer;
//   int _start = 30; // Cooldown period for resending
//   bool _canResend = false;

//   @override
//   void initState() {
//     super.initState();
//     _currentVerificationId = widget.vid;
//     _currentResendToken = widget.resendToken;
//     startTimer();
//   }

//   @override
//   void dispose() {
//     _timer?.cancel(); // Cancel the timer when the widget is removed
//     otpController.dispose();
//     super.dispose();
//   }

//   // Function to start the countdown timer
//   void startTimer() {
//     const oneSec = Duration(seconds: 1);
//     _timer = Timer.periodic(
//       oneSec,
//       (Timer timer) {
//         if (_start == 0) {
//           setState(() {
//             timer.cancel();
//             _canResend = true; // Enable the resend button after timeout
//           });
//         } else {
//           setState(() {
//             _start--;
//           });
//         }
//       },
//     );
//   }

//   // Function to resend the OTP using the forceResendingToken
//   void _resendOtp() {
//     if (_currentResendToken == null)
//       return; // Should not happen if initiated correctly

//     setState(() {
//       _canResend = false;
//       _start = 30; // Reset the timer duration
//       startTimer(); // Start the timer again
//     });

//     FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: widget.phn_number,
//       verificationCompleted: (PhoneAuthCredential credential) {},
//       verificationFailed: (FirebaseAuthException ex) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to resend OTP: ${ex.message}')),
//         );
//         setState(() {
//           _canResend = true;
//           _timer?.cancel();
//         });
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         // Update the verification ID and token with the new values from Firebase
//         setState(() {
//           _currentVerificationId = verificationId;
//           _currentResendToken = resendToken;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('New OTP sent successfully!')),
//         );
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {},
//       // Crucial part: use the stored token to force a new SMS
//       forceResendingToken: _currentResendToken,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SizedBox.expand(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // ... (Image and Title UI code omitted for brevity)
//                 Image.asset('assets/images/otp.png', height: 128),
//                 Column(
//                   children: [
//                     Text('OTP Verfication',
//                         style: TextStyle(
//                             fontSize: 32, fontWeight: FontWeight.w500)),
//                     Text(
//                       'One Time Password(OTP) has been sent to via SMS\n                             to ${widget.phn_number}',
//                       style: TextStyle(fontSize: 14, color: Colors.grey),
//                     )
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       'Enter the OTP below to verify it',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
//                     ),
//                     Pinput(
//                       controller: otpController,
//                       length: 6,
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     MyButton(
//                       btntxt: 'VERIFY OTP',
//                       onClick: () async {
//                         try {
//                           print('this part run');
//                           StreamBuilder<QuerySnapshot>(
//                             stream: _firestore.getUser(),
//                             builder: (context, snapshot) {
//                               print("Stream run");
//                               if (snapshot.hasData) {
//                                 List users = snapshot.data!.docs;

//                                 return ListView.builder(
//                                   itemCount: users.length,
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     print('Listview run');
//                                     DocumentSnapshot document = users[index];
//                                     print(
//                                         "${widget.phn_number}  ${document.id}");
//                                     if (widget.phn_number == document.id) {
//                                       setState(() {
//                                         _isThere = true;
//                                       });
//                                     }
//                                     ;
//                                     return ListTile(
//                                       title: Text(document.id),
//                                     );
//                                   },
//                                 );
//                               } else {
//                                 return Text('No data available');
//                               }
//                             },
//                           );

//                           PhoneAuthCredential credential =
//                               await PhoneAuthProvider.credential(
//                             // Use the local state variable, not widget.vid
//                             verificationId: _currentVerificationId,
//                             smsCode: otpController.text,
//                           );

//                           await FirebaseAuth.instance
//                               .signInWithCredential(credential)
//                               .then((value) {
//                             // Cancel timer on successful verification before navigating
//                             _timer?.cancel();
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => _isThere
//                                     ? HomeScreen()
//                                     : SignupScreen(
//                                         phn_number: widget.phn_number,
//                                       ),
//                               ),
//                             );
//                           });
//                         } catch (ex) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text(
//                                   'Entered an invalid OTP or an error occurred.'),
//                             ),
//                           );
//                         }
//                       },
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Didn’t receive the code? ',
//                           style: TextStyle(fontSize: 14, color: Colors.grey),
//                         ),
//                         // Display the countdown or the clickable "Resend OTP" text
//                         GestureDetector(
//                           onTap: _canResend
//                               ? _resendOtp
//                               : null, // Only clickable when _canResend is true
//                           child: Text(
//                             _canResend ? 'Resend OTP' : 'Resend in $_start s',
//                             style: TextStyle(
//                               color: _canResend ? Colors.blue : Colors.grey,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               decoration: _canResend
//                                   ? TextDecoration.underline
//                                   : TextDecoration.none,
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:mistri_app/components/my_button.dart';
// // import 'package:mistri_app/screens/home_screen.dart';
// // import 'package:mistri_app/screens/signup_screen.dart';
// // import 'package:pinput/pinput.dart';

// // class OtpverificationScreen extends StatefulWidget {
// //   String vid;
// //   String phn_number;
// //   OtpverificationScreen({
// //     super.key,
// //     required this.vid,
// //     required this.phn_number, int? resendToken,
// //   });

// //   @override
// //   State<OtpverificationScreen> createState() => _OtpverificationScreenState();
// // }

// // class _OtpverificationScreenState extends State<OtpverificationScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     TextEditingController otpController = TextEditingController();

// //     return Scaffold(
// //       body: SafeArea(
// //         child: SizedBox.expand(
// //           child: Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 20),
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //               crossAxisAlignment: CrossAxisAlignment.center,
// //               children: [
// //                 Image.asset(
// //                   'assets/images/otp.png',
// //                   height: 128,
// //                 ),
// //                 Column(
// //                   children: [
// //                     Text(
// //                       'OTP Verfication',
// //                       style: TextStyle(
// //                         fontSize: 32,
// //                         fontWeight: FontWeight.w500,
// //                       ),
// //                     ),
// //                     Text(
// //                       'One Time Password(OTP) has been sent to via SMS\n                             to 01XXXXXXX99',
// //                       style: TextStyle(
// //                         fontSize: 14,
// //                         color: Colors.grey,
// //                       ),
// //                     )
// //                   ],
// //                 ),
// //                 Column(
// //                   children: [
// //                     Text(
// //                       'Enter the OTP below to verify it',
// //                       style: TextStyle(
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.w400,
// //                       ),
// //                     ),
// //                     Pinput(
// //                       controller: otpController,
// //                       length: 6,
// //                     ),
// //                   ],
// //                 ),
// //                 Column(
// //                   children: [
// //                     MyButton(
// //                       btntxt: 'VERIFY OTP',
// //                       onClick: () async {
// //                         try {
// //                           PhoneAuthCredential credential =
// //                               await PhoneAuthProvider.credential(
// //                             verificationId: widget.vid,
// //                             smsCode: otpController.text,
// //                           );

// //                           await FirebaseAuth.instance
// //                               .signInWithCredential(credential)
// //                               .then((value) {
// //                             Navigator.push(
// //                               context,
// //                               MaterialPageRoute(
// //                                 builder: (context) => SignupScreen(
// //                                   phn_number: widget.phn_number,
// //                                 ),
// //                               ),
// //                             );
// //                           });
// //                         } catch (ex) {
// //                           ScaffoldMessenger.of(context).showSnackBar(
// //                             SnackBar(
// //                               content: Text('Enter a invalid otp'),
// //                             ),
// //                           );
// //                         }
// //                       },
// //                     ),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         Text(
// //                           'Didn’t receive the code? ',
// //                           style: TextStyle(
// //                             fontSize: 14,
// //                             color: Colors.grey,
// //                           ),
// //                         ),
// //                         Text(
// //                           'Resend OTP',
// //                           style: TextStyle(
// //                             color: Colors.blue,
// //                             fontSize: 14,
// //                             fontWeight: FontWeight.w400,
// //                           ),
// //                         ),
// //                       ],
// //                     )
// //                   ],
// //                 )
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
