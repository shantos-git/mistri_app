import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mistri_app/components/my_button.dart';
import 'package:mistri_app/services/auth/auth_gate.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _currentIndex = 0;
  late Timer _timer;

  final List<String> _backgroundImages = [
    'assets/images/background-1.png',
    'assets/images/background-2.png',
    'assets/images/background-3.png',
  ];

  final List<String> heading_1st = [
    'Find Help',
    'Instant &',
    'Pay Securely &',
  ];

  final List<String> heading_2st = [
    'Near You',
    'Scheduled Jobs',
    'Rate Worker',
  ];

  final List<String> description_1st = [
    'Discover trusted professionals for electrical, plumbing,',
    'Book jobs on-demand or plan ahead. Mistri connects ',
    'Make secure payments after the job is done. Rate',
  ];

  final List<String> description_2st = [
    'cleaning, and more right in your neighborhood',
    'you with workers in real time.',
    'your experience to help others',
  ];

  void onClick() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthGate(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _backgroundImages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          //for background
          AnimatedSwitcher(
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeIn,
            duration: Duration(seconds: 5),
            child: SizedBox(
              height: double.infinity,
              child: Image.asset(
                _backgroundImages[_currentIndex],
                key: ValueKey<String>(_backgroundImages[_currentIndex]),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),

          // opacithy over background
          Container(color: Colors.black.withOpacity(0.5)),

          // other contents
          Container(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height - 330,
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 600),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              heading_1st[_currentIndex],
                              key: ValueKey<String>(heading_1st[_currentIndex]),
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              heading_2st[_currentIndex],
                              key: ValueKey<String>(heading_2st[_currentIndex]),
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              description_1st[_currentIndex],
                              key: ValueKey<String>(
                                  description_1st[_currentIndex]),
                              style: TextStyle(
                                fontSize: 13,
                                color: const Color.fromARGB(255, 189, 189, 189),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              description_2st[_currentIndex],
                              key: ValueKey<String>(
                                  description_2st[_currentIndex]),
                              style: TextStyle(
                                fontSize: 13,
                                color: const Color.fromARGB(255, 189, 189, 189),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  child: MyButton(
                    btntxt: 'GET STARTED',
                    onClick: onClick,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
