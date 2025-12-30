import 'package:flutter/material.dart';
import 'package:mistri_app/components/bottom_navigation.dart';
import 'package:mistri_app/screens/allService_screen.dart';
import 'package:mistri_app/screens/booking_screen.dart';
import 'package:mistri_app/screens/firstHome_screen.dart';
import 'package:mistri_app/screens/profile_screen.dart';
import 'package:mistri_app/screens/worker_dashboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void navigateBottombar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> pages = [
    FirsthomeScreen(),
    AllservicePage(),
    BookingScreen(),
    Profile_screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigation(
        onTap: (index) => navigateBottombar(index),
        myIndex: _selectedIndex,
      ),
    );
  }
}
