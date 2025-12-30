import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  IconData icon;
  String headline;
  String info;
  InfoCard({
    super.key,
    required this.icon,
    required this.headline,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 35,
          color: Colors.grey,
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(headline),
            Text(info),
          ],
        ),
      ],
    );
  }
}
