import 'package:flutter/material.dart';

class ResetContainer extends StatelessWidget {
  IconData icon;
  String via;
  String adress;
  Function onTap;
  ResetContainer({
    super.key,
    required this.icon,
    required this.via,
    required this.adress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 15,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 236, 236, 236),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color.fromARGB(255, 72, 70, 70),
              size: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    via,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    adress,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
