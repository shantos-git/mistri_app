import 'package:flutter/material.dart';
import 'package:mistri_app/screens/login_screen.dart';

class PassconfirmScreen extends StatelessWidget {
  const PassconfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Password Updated',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Image.asset(
                'assets/images/confirm.png',
                height: 160,
                width: 160,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Your Password has been updated successfully!',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 60,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: Text(
                  'BACK TO LOGIN',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Monument',
                    color: Colors.blue,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
