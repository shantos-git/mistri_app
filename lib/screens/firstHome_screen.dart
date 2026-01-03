import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mistri_app/components/offer_card.dart';
import 'package:mistri_app/components/populerjob_grid.dart';
import 'package:mistri_app/helper/category_card.dart';
import 'package:mistri_app/screens/jobPost_screen.dart';
import 'package:mistri_app/screens/profile_screen.dart';
import 'package:mistri_app/screens/user_map_screen.dart';

class FirsthomeScreen extends StatelessWidget {
  const FirsthomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(
                height: 160,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/only_logo.png',
                              height: 32,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'MISTRI',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Monument',
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Profile_screen(),
                              ),
                            );
                            // FirebaseAuth.instance.signOut();
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Image.network(
                              'https://images.unsplash.com/photo-1457449940276-e8deed18bfff?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                              height: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserMapScreen(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_pin),
                              Text('Mirpur 10, Dhaka'),
                            ],
                          ),
                          Icon(Icons.chevron_right_sharp),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JobpostScreen(),
                            ),
                          );
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.add_box_outlined),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    'Post a  Job',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              // Container(
                              //   height: 36,
                              //   width: 90,
                              //   decoration: BoxDecoration(
                              //     color: Colors.white,
                              //     borderRadius: BorderRadius.circular(25),
                              //   ),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceEvenly,
                              //     children: [
                              //       Icon(Icons.calendar_month_outlined),
                              //       Text('Later'),
                              //     ],
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CategoryCard(
                title: "Offers",
                onTap: () {},
              ),
              SizedBox(
                width: double.infinity,
                height: 175,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    List imagepath = [
                      'assets/images/offer1.png',
                      'assets/images/offer2.png',
                      'assets/images/offer3.png'
                    ];
                    return OfferCard(
                      imagepath: imagepath[index],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 36,
              ),
              CategoryCard(
                title: "Services",
                onTap: () {},
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 100,
                child: PopulerjobGrid(
                  item: 3,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 36,
              ),
              // CategoryCard(
              //   title: "Nearby Workers",
              //   onTap: () {},
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   height: 210,
              //   width: double.infinity,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: 4,
              //     itemBuilder: (BuildContext context, int index) {
              //       return WorkerCard();
              //     },
              //   ),
              // ),
              // SizedBox(
              //   height: 36,
              // ),
              // CategoryCard(
              //   title: "Populer in Your Area",
              //   onTap: () {},
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // SizedBox(
              //   width: double.infinity,
              //   height: 175,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: 3,
              //     itemBuilder: (BuildContext context, int index) {
              //   // return OfferCard();
              // },
              // ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
