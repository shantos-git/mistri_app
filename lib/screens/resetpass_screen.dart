import 'package:flutter/material.dart';
import 'package:mistri_app/components/reset_container.dart';
import 'package:mistri_app/screens/newpassset_screen.dart';

class ResetpassScreen extends StatefulWidget {
  const ResetpassScreen({super.key});

  @override
  State<ResetpassScreen> createState() => _ResetpassScreenState();
}

class _ResetpassScreenState extends State<ResetpassScreen> {
  void onTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewpasssetScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/security.png',
                height: 180,
              ),
              SizedBox(
                height: 50,
              ),
              ResetContainer(
                icon: Icons.phone_android,
                via: 'via SMS',
                adress: '+88019XX-XXXXXX',
                onTap: onTap,
              ),
              ResetContainer(
                icon: Icons.mail,
                via: 'via Mail',
                adress: 'support@gmail.com',
                onTap: onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
