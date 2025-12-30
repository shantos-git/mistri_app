import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mistri_app/components/customer_review_card.dart';
import 'package:mistri_app/components/filter_card.dart';
import 'package:mistri_app/components/info_card.dart';

class WorkerDetailsScreen extends StatelessWidget {
  const WorkerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(64),
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: Stack(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://www.shutterstock.com/shutterstock/photos/2031893195/display_1500/stock-photo-silhouette-of-black-sports-car-with-led-headlights-on-black-background-copy-space-2031893195.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Mobashsher Hasan Anik',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Onest',
                fontWeight: FontWeight.w500,
                height: 0.89,
                letterSpacing: -0.72,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '@mhanik',
              style: TextStyle(
                color: const Color(0xFF7F7F7F),
                fontSize: 14,
                fontFamily: 'Onest',
                fontWeight: FontWeight.w500,
                height: 1.14,
                letterSpacing: -0.56,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    // ----- TAB BAR -----
                    TabBar(
                      indicatorColor: Colors.black,
                      indicatorWeight: 2,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: const [
                        Tab(text: "About"),
                        Tab(text: "Reviews"),
                      ],
                    ),

                    // ----- TAB CONTENT -----
                    Expanded(
                      child: TabBarView(
                        children: [
                          //for the about section
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 392,
                                    child: Text(
                                      'User information',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Onest',
                                        fontWeight: FontWeight.w600,
                                        height: 1.20,
                                        letterSpacing: -0.80,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  SizedBox(
                                    width: 348,
                                    child: Text(
                                      'Skilled and reliable electrician with 5+ years of experience in residential and commercial electrical work. Expert in wiring, installations, repairs, and safety inspections. Known for quick problem-solving, clean workmanship, and a customer-first attitude. Dedicated to delivering safe, efficient, and long-lasting electrical solutions.',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Onest',
                                        fontWeight: FontWeight.w400,
                                        height: 1.25,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 32,
                                  ),
                                  SizedBox(
                                    height: 200,
                                    child: GridView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 3,
                                      ),
                                      itemCount: 5,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InfoCard(
                                          icon: Icons.location_on_outlined,
                                          headline: 'From',
                                          info: 'Mirpur, Dhaka',
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 32,
                                  ),
                                  SizedBox(
                                    width: 392,
                                    child: Text(
                                      'Skills',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Onest',
                                        fontWeight: FontWeight.w600,
                                        height: 1.20,
                                        letterSpacing: -0.80,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  SizedBox(
                                    height: 200,
                                    child: GridView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 1.5,
                                      ),
                                      itemCount: 6,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return FilterCard(
                                          index: index,
                                          filterItem: [
                                            'Light Repair',
                                            'Wiring & Circuit',
                                            'Fan Installation',
                                            'Inverter Installation',
                                            'Switchboard Fix',
                                            'Generator Setup',
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //for the reviews section

                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Overall rating',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'Onest',
                                          fontWeight: FontWeight.w600,
                                          height: 1.20,
                                          letterSpacing: -0.80,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.star),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '5.0',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 27,
                                              fontFamily: 'Onest',
                                              fontWeight: FontWeight.w500,
                                              height: 0.89,
                                              letterSpacing: -1.08,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Worker communication',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Onest',
                                          fontWeight: FontWeight.w400,
                                          height: 1.20,
                                          letterSpacing: -0.80,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.star),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '5.0',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontFamily: 'Onest',
                                              fontWeight: FontWeight.w500,
                                              height: 0.89,
                                              letterSpacing: -1.08,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Quality of service',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Onest',
                                          fontWeight: FontWeight.w400,
                                          height: 1.20,
                                          letterSpacing: -0.80,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.star),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '5.0',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontFamily: 'Onest',
                                              fontWeight: FontWeight.w500,
                                              height: 0.89,
                                              letterSpacing: -1.08,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Value of delivery',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Onest',
                                          fontWeight: FontWeight.w400,
                                          height: 1.20,
                                          letterSpacing: -0.80,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.star),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '5.0',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontFamily: 'Onest',
                                              fontWeight: FontWeight.w500,
                                              height: 0.89,
                                              letterSpacing: -1.08,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 32,
                                  ),
                                  Divider(
                                    thickness: 3,
                                  ),
                                  SizedBox(
                                    height: 32,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Sorted by',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Onest',
                                          fontWeight: FontWeight.w600,
                                          height: 1.50,
                                          letterSpacing: -0.64,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              icon: Icon(
                                                CupertinoIcons.chevron_down,
                                              ),
                                              items: [
                                                DropdownMenuItem(
                                                  child: Text('Most relevent'),
                                                ),
                                                DropdownMenuItem(
                                                  value: 'Old',
                                                  child: Text('Old'),
                                                ),
                                                DropdownMenuItem(
                                                  value: 'Newest',
                                                  child: Text('Newest'),
                                                ),
                                              ],
                                              onChanged: (value) {},
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 32,
                                  ),
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 6,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: CustomerReviewCard(),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
