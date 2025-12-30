import 'package:flutter/material.dart';

class FilterCard extends StatelessWidget {
  int index;
  List filterItem;
  FilterCard({super.key, required this.index, required this.filterItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 14,
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          filterItem[index],
          style: TextStyle(
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
