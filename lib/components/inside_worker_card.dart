import 'package:flutter/material.dart';

class InsideWorkerCard extends StatelessWidget {
  VoidCallback onTap;
  VoidCallback accept;
  InsideWorkerCard({
    super.key,
    required this.onTap,
    required this.accept,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 148,
        width: 392,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(),
                Text(
                  'rakibul islam shanto',
                )
              ],
            ),
            ElevatedButton(
              onPressed: accept,
              child: Text('Except'),
            ),
          ],
        ),
      ),
    );
  }
}
