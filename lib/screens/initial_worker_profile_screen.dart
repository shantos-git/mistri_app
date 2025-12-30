import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mistri_app/components/my_button.dart';
import 'package:mistri_app/screens/worker_details_screen.dart';

class InitialWorkerProfileScreen extends StatefulWidget {
  InitialWorkerProfileScreen({super.key});

  @override
  State<InitialWorkerProfileScreen> createState() =>
      _InitialWorkerProfileScreenState();
}

class _InitialWorkerProfileScreenState
    extends State<InitialWorkerProfileScreen> {
  List images = [
    'https://www.shutterstock.com/shutterstock/photos/2031893195/display_1500/stock-photo-silhouette-of-black-sports-car-with-led-headlights-on-black-background-copy-space-2031893195.jpg',
    'https://www.shutterstock.com/shutterstock/photos/1736817095/display_1500/stock-photo-detail-on-one-of-the-led-headlights-super-car-copy-space-1736817095.jpg',
    'https://www.shutterstock.com/shutterstock/photos/2585189477/display_1500/stock-photo-la-ca-usa-february-lamborghini-huracan-parked-showing-the-carbon-fiber-front-end-of-the-2585189477.jpg',
  ];

  int current_index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 260,
              width: double.infinity,
              child: Stack(
                children: [
                  SizedBox(
                    height: 260,
                    width: double.infinity,
                    child: PageView.builder(itemBuilder: (context, index) {
                      return SizedBox(
                        height: 260,
                        width: double.infinity,
                        child: Image.network(
                          images[index % images.length],
                          fit: BoxFit.cover,
                        ),
                      );
                    }),
                  ),
                  Positioned(
                    right: 20,
                    bottom: 20,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: ShapeDecoration(
                        color: Colors.black.withValues(alpha: 0.40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(38),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Text(
                            '${current_index}/${images.length}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Onest',
                              fontWeight: FontWeight.w500,
                              height: 0.89,
                              letterSpacing: -0.72,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                height: 60,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 48,
                      width: 48,
                      child: Stack(
                        children: [
                          Container(
                            height: 48,
                            width: 48,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              images[1],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 2,
                            right: 2,
                            child: Container(
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 13,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Silver',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.33,
                                  fontFamily: 'Onest',
                                  fontWeight: FontWeight.w500,
                                  height: 1,
                                  letterSpacing: -0.53,
                                ),
                              ),
                              Icon(
                                Icons.star,
                                size: 10,
                              ),
                              Icon(
                                Icons.star,
                                size: 10,
                              ),
                              Icon(
                                Icons.star,
                                size: 10,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Icon(CupertinoIcons.chevron_down),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                  'I’m Anik, a skilled electrician dedicated to providing outstanding electrical services for your home. With my expertise in home wiring, appliance installation,'),
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'Any Kind of repair - Starts from 300',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Onest',
                  fontWeight: FontWeight.w500,
                  height: 1.20,
                  letterSpacing: -0.80,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 70,
                left: 24,
                right: 24,
                bottom: 24,
              ),
              child: MyButton(
                  btntxt: 'Continue',
                  onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkerDetailsScreen(),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
