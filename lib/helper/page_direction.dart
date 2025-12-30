import 'package:flutter/material.dart';

class PageDirection extends StatelessWidget {
  String previous;
  String next;

  PageDirection({super.key, required this.previous, required this.next});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            previous,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          '>',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          next,
          style: TextStyle(
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
