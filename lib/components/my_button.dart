import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  String btntxt;
  Function onClick;
  MyButton({
    super.key,
    required this.btntxt,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromARGB(255, 40, 214, 183),
            const Color.fromARGB(255, 23, 152, 244),
          ],
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ElevatedButton(
        onPressed: () => onClick(),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Colors.transparent, // Make button background transparent
          shadowColor: Colors.transparent, // Remove shadow if desired
          padding: EdgeInsets.symmetric(
              horizontal: 40, vertical: 15), // Adjust padding
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12.0), // Match container's border radius
          ),
        ),
        child: Text(
          btntxt,
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
            fontFamily: 'Monument',
          ),
        ),
      ),
    );
  }
}
