import 'package:flutter/material.dart';
import 'package:mistri_app/components/my_button.dart';
import 'package:mistri_app/screens/mistri_account_scrren2.dart';

class MistriAccountScreen extends StatelessWidget {
  const MistriAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Become a Mistri'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset('assets/images/become.png'),
            ),
            SizedBox(
              height: 54,
            ),
            Text(
              'Earn with your skill',
              style: TextStyle(
                color: const Color(0xFF292929),
                fontSize: 40,
                fontFamily: 'Onest',
                fontWeight: FontWeight.w700,
                height: 1.20,
                letterSpacing: -1.60,
              ),
            ),
            SizedBox(
              height: 9,
            ),
            Text(
              'Become a local expert',
              style: TextStyle(
                color: const Color(0xFF2094F0),
                fontSize: 24,
                fontFamily: 'Onest',
                fontWeight: FontWeight.w500,
                height: 1.33,
                letterSpacing: -0.96,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            SizedBox(
              width: 336,
              child: Text(
                'Your experience matters. Add your details to help clients choose you with confidence.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF888888),
                  fontSize: 16,
                  fontFamily: 'Onest',
                  fontWeight: FontWeight.w500,
                  height: 1.50,
                  letterSpacing: -0.64,
                ),
              ),
            ),
            SizedBox(
              height: 54,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: MyButton(
                btntxt: 'Register as a Mistri',
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MistriAccountScrren2(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
