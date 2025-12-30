import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  Function(int)? onTap;
  int myIndex;
  BottomNavigation({
    super.key,
    required this.onTap,
    required this.myIndex,
  });

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: widget.onTap,
        currentIndex: widget.myIndex,
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.grey,
                size: 35,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.apps,
                color: Colors.grey,
                size: 35,
              ),
              label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmark,
                color: Colors.grey,
                size: 35,
              ),
              label: 'Booking'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_box_rounded,
                color: Colors.grey,
                size: 35,
              ),
              label: 'Profile'),
        ]);
  }
}
