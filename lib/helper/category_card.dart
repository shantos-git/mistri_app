import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  String title;
  VoidCallback? onTap;

  CategoryCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(82, 82, 82, 1),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
