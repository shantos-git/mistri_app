import 'package:flutter/material.dart';
import 'package:mistri_app/models/grid_model.dart';
import 'package:mistri_app/screens/electronic_service_screen.dart';
import 'package:mistri_app/screens/cleaning_screen.dart';
import 'package:mistri_app/screens/plumbing_service_screen.dart';

class PopulerjobGrid extends StatelessWidget {
  int item;

  PopulerjobGrid({
    super.key,
    required this.item,
  });

  List<GridItem> items = [
    GridItem(
        title: 'Electrical',
        icon: Icons.electrical_services_outlined,
        targetPage: ElectronicServiceScreen()),
    GridItem(
        title: 'Plumbing',
        icon: Icons.settings,
        targetPage: PlumbingServiceScreen()),
    GridItem(
      title: 'Cleaning',
      icon: Icons.person,
      targetPage: CleaningScreen(),
    ),

    // Add more items
  ];

  @override
  Widget build(BuildContext context) {
    List jobs = [
      ['Electrical', 'assets/images/Vector.png'],
      ['Plumbing', 'assets/images/Vector (2).png'],
      ['Cleaning', 'assets/images/Vector (1).png'],
      'Gas Stove',
      'Painting',
      'Furniture',
      'Appliance',
      'Moving',
      'Masonry',
      'Carpentry',
      'Car Service',
      'Electronics',
      'Paunishkashon',
      'nterior Design',
    ];
    return GridView.builder(
      // physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 22,
        crossAxisSpacing: 22,
      ),
      itemCount: item,
      itemBuilder: (BuildContext context, int index) {
        final itm = items[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => itm.targetPage,
              ),
            );
          },
          child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 225, 225),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(jobs[index][1]),
                  Text(
                    jobs[index][0],
                  )
                ],
              )),
        );
      },
    );
  }
}
