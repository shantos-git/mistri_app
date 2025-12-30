import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SigninBox extends StatelessWidget {
  const SigninBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 60),
        child: Column(
          children: [
            Text('Or sign in with'),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(),
                    ),
                    child: Image.asset(
                      'assets/images/google.png',
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(),
                    ),
                    child: Image.asset(
                      'assets/images/ios.png',
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(),
                    ),
                    child: Image.asset(
                      'assets/images/sms.png',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Terms & Policy',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
                Text(
                  'User Agreement & Licesense',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
