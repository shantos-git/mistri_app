import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mistri_app/components/filter_card.dart';
import 'package:mistri_app/components/inside_worker_card.dart';
import 'package:mistri_app/components/worker_do_card.dart';
import 'package:mistri_app/helper/page_direction.dart';
import 'package:mistri_app/screens/filtering_screen.dart';
import 'package:mistri_app/screens/initial_worker_profile_screen.dart';

class ElectronicServiceScreen extends StatelessWidget {
  const ElectronicServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 64,
            left: 24,
            right: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageDirection(previous: "All Services", next: "Electrical"),
              SizedBox(
                height: 16,
              ),
              Text(
                'Electrical Services',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Text(
                'Get trusted electricians near your area',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return FilterCard(
                            index: index,
                            filterItem: [
                              'All',
                              'Top Rated',
                              'Closest',
                              'Lowest Price',
                              'Most Experienced',
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  VerticalDivider(
                    width: 20,
                    thickness: 1,
                    indent: 20,
                    endIndent: 0,
                    color: Colors.grey,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FilteringScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        CupertinoIcons.line_horizontal_3_decrease,
                        size: 32,
                      ))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Expanded(
                  child: WorkerDoCard(),
                ),
              ),
              Container(
                child: Expanded(
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        // child: InsideWorkerCard(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) =>
                        //             InitialWorkerProfileScreen(),
                        //       ),
                        //     );
                        //   },
                        // ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
