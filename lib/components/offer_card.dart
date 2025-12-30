import 'package:flutter/material.dart';

class OfferCard extends StatelessWidget {
  String imagepath;
  OfferCard({
    super.key,
    required this.imagepath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(
        right: 16,
      ),
      height: 165,
      width: 345,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Image.asset(
        imagepath,
        fit: BoxFit.cover,
      ),
    );
  }
}
