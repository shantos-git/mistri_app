import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mistri_app/components/offer_card.dart';
import 'package:mistri_app/components/populerjob_grid.dart';
import 'package:mistri_app/helper/category_card.dart';
import 'package:mistri_app/models/universal_model.dart';
import 'package:mistri_app/screens/jobPost_screen.dart';
import 'package:mistri_app/screens/profile_screen.dart';
import 'package:mistri_app/screens/user_map_screen.dart';
import 'package:provider/provider.dart';

class FirsthomeScreen extends StatefulWidget {
  const FirsthomeScreen({super.key});

  @override
  State<FirsthomeScreen> createState() => _FirsthomeScreenState();
}

class _FirsthomeScreenState extends State<FirsthomeScreen> {
  String address = "Select location";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final number =
          Provider.of<UniversalModel>(context, listen: false).phone_number;

      if (number.isNotEmpty) {
        _loadUserAddress(number);
      }
    });
  }

// Modify your method to accept the number
  Future<void> _loadUserAddress(String number) async {
    if (number.isEmpty) return;

    final doc =
        await FirebaseFirestore.instance.collection('Users').doc(number).get();
    if (doc.exists && doc.data()!.containsKey('adress')) {
      setState(() {
        address = doc['adress'];
      });
    }
  }

  /// 🔹 Change location using map
  Future<void> _changeLocation() async {
    // Navigate to the map screen
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const UserLocationMap()),
    );

    if (result == null) return;

    // Safely get the user's phone number from Provider
    final number =
        Provider.of<UniversalModel>(context, listen: false).phone_number;

    if (number == null || number.isEmpty) {
      // If phone number is not available yet, show error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("User number not found. Try again later.")),
      );
      return;
    }

    // Update Firestore with new location
    await FirebaseFirestore.instance.collection('Users').doc(number).update({
      'adress': result['address'], // make sure key matches your map
      'latitude': result['lat'],
      'longitude': result['lng'],
    });

    // Update UI with new address
    setState(() {
      address = result['address'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(
                height: 160,
                child: Column(
                  children: [
                    /// 🔹 TOP BAR
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/only_logo.png',
                              height: 32,
                            ),
                            const SizedBox(width: 10),
                            const Text(
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
                                builder: (_) => Profile_screen(),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 22,
                            backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1457449940276-e8deed18bfff',
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// 📍 LOCATION ROW
                    GestureDetector(
                      onTap: _changeLocation,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Icons.location_pin),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    address,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// ➕ POST JOB
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => JobpostScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Row(
                              children: [
                                Icon(Icons.add_box_outlined),
                                SizedBox(width: 16),
                                Text(
                                  'Post a Job',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              CategoryCard(title: "Offers", onTap: () {}),
              SizedBox(
                height: 175,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (_, index) {
                    final images = [
                      'assets/images/offer1.png',
                      'assets/images/offer2.png',
                      'assets/images/offer3.png'
                    ];
                    return OfferCard(imagepath: images[index]);
                  },
                ),
              ),
              const SizedBox(height: 36),
              CategoryCard(title: "Services", onTap: () {}),
              const SizedBox(height: 10),
              SizedBox(height: 100, child: PopulerjobGrid(item: 3)),
            ],
          ),
        ),
      ),
    );
  }
}
