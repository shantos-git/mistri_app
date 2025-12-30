import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mistri_app/firebase_services/firestore.dart';
import 'package:mistri_app/models/Job.dart';
import 'package:mistri_app/screens/firstHome_screen.dart';
import 'package:mistri_app/screens/home_screen.dart';
import 'package:mistri_app/screens/worker_dashboard.dart';

class JobpostScreen extends StatefulWidget {
  const JobpostScreen({super.key});

  @override
  State<JobpostScreen> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<JobpostScreen> {
  Firestore _firestore = Firestore();

  String selectedServiceType = "Electrical";
  String? selectedService;
  String? selectedSpecific;
  bool first = true;
  bool second = false;
  bool third = false;
  String selectedPaymentMethod = 'COD';

  List<String> paymentMethod = ['COD', 'Bkash', 'Nagad'];

  List<String> serviceTypes = ["Electrical", "Plumbing", "Cleaning"];

  List<String> generalElectrical = [
    "Switch repair / replacement",
    "Socket repair / replacement",
    "Fuse replacement",
    "MCB / breaker repair",
    "Short-circuit fixing",
    "Power outage troubleshooting",
    "Others"
  ];

  List<String> plumbingCategories = [
    'General Repair & Maintenance',
    'Drain Cleaning & Clogging',
    'Pipe Installation & Replacement',
    'Fixture Installation (Toilets, Sinks, Faucets)',
    'Water Heater Services',
    'Sewer Line Services',
    'Leak Detection',
    'Water Filtration Systems',
    'Emergency Plumbing',
    'Septic Tank Services',
  ];

  Map<String, String> prices = {
    "Switch repair / replacement": "৳100.00",
    "Socket repair / replacement": "৳100.00",
    "Fuse replacement": "৳100.00",
    "MCB / breaker repair": "৳140.00",
    "Short-circuit fixing": "৳300.00",
    "Power outage troubleshooting": "৳200.00",
    "Others": "৳0.00",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: third
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // ---------------- STEP INDICATOR ----------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _stepCircle("1", first),
                        _stepLine(),
                        _stepCircle("2", second),
                        _stepLine(),
                        _stepCircle("3", third),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text("Post"),
                        Text("Payment"),
                        Text("Confirm"),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // ---------------- SERVICE TYPE ----------------
                    const Text("Service Info",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),

                    Row(children: [
                      Expanded(child: Icon(Icons.location_on_outlined)),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'House 01, Block-D, Road 07, Mirpur 10, Dhaka-1216',
                      )
                    ]),

                    Row(children: [
                      Icon(Icons.calendar_month_rounded),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '2:30pm, Sun, 7 Dec, 2025',
                      )
                    ]),

                    const SizedBox(height: 20),

                    const Text("Payment Info",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 12,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total bill',
                        ),
                        Text(
                          '৳335',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),

                    SizedBox(
                      height: 12,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payment Option',
                        ),
                        Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(),
                          ),
                          child: Center(
                            child: Text(selectedPaymentMethod),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ---------------- SPECIFIC SERVICE ----------------

                    const SizedBox(height: 20),

                    // ---------------- PROCEED BUTTON ----------------
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Job newJob = Job(
                                  userid:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  username: 'Rakibul Islam Shanto',
                                  workerid: '',
                                  category: selectedServiceType,
                                  description:
                                      '${selectedService} , ${selectedSpecific}',
                                  paymentMethod: selectedPaymentMethod,
                                  bill: '320',
                                  postTime: DateTime.now().toString(),
                                  phnNumber: '0192391942',
                                );

                                _firestore.addJob(newJob);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text(
                                "Confirm post",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                )
              : second
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),

                        // ---------------- STEP INDICATOR ----------------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _stepCircle("1", first),
                            _stepLine(),
                            _stepCircle("2", second),
                            _stepLine(),
                            _stepCircle("3", third),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text("Post"),
                            Text("Payment"),
                            Text("Confirm"),
                          ],
                        ),

                        const SizedBox(height: 25),

                        // ---------------- SERVICE TYPE ----------------
                        const Text("Service Details",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Column(
                          children: [
                            _serviceDetails(
                                'Service Type', selectedServiceType),
                            _serviceDetails(
                              'Service',
                              selectedService.toString(),
                            ),
                            _serviceDetails(
                              'Specification',
                              selectedSpecific.toString(),
                            ),
                            _serviceDetails(
                              'Service Date',
                              DateTime.now().toString(),
                            ),
                            _serviceDetails(
                              'Schedule Time',
                              DateTime.now().toString(),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        const Text("Delivery Details",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Text(
                                  'House 01, Block-D, Road 07, Mirpur 10, Dhaka-1216',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: Center(
                                      child: Text(
                                        'Change adress',
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 20),

                        const Text("Payment Details",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Column(
                          children: [
                            _serviceDetails(
                              'Base Rate',
                              prices[selectedSpecific].toString(),
                            ),
                            _serviceDetails(
                              'Distance',
                              '৳30',
                            ),
                            _serviceDetails(
                              'Time',
                              '৳10',
                            ),
                          ],
                        ),

                        Divider(),

                        Column(
                          children: [
                            _serviceDetails(
                              'Subtotal',
                              '৳${double.parse(prices[selectedSpecific].toString().substring(1)) + 30 + 10}',
                            ),
                            _serviceDetails(
                              'Service carge',
                              '৳5',
                            ),
                            _serviceDetails(
                              'Discount',
                              '৳10',
                            ),
                          ],
                        ),

                        Divider(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '৳${double.parse(prices[selectedSpecific].toString().substring(1)) + 30 + 10 + 5 - 10}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),

                        Divider(),

                        const SizedBox(height: 20),

                        const Text("Choose Payment Method",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),

                        Row(
                          children: paymentMethod.map((t) {
                            bool active = selectedPaymentMethod == t;
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ChoiceChip(
                                avatar: Icon(Icons.money_rounded),
                                label: Text(t),
                                selected: active,
                                selectedColor: Colors.blue,
                                labelStyle: TextStyle(
                                    color:
                                        active ? Colors.white : Colors.black),
                                onSelected: (_) {
                                  setState(() {
                                    selectedPaymentMethod = t;
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        ),

                        // ---------------- PROCEED BUTTON ----------------
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                third = true;
                              });
                              print(second);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text(
                              "Proceed",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    )
                  :
                  //this is the first page
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),

                        // ---------------- STEP INDICATOR ----------------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _stepCircle("1", first),
                            _stepLine(),
                            _stepCircle("2", second),
                            _stepLine(),
                            _stepCircle("3", third),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text("Post"),
                            Text("Payment"),
                            Text("Confirm"),
                          ],
                        ),

                        const SizedBox(height: 25),

                        // ---------------- SERVICE TYPE ----------------
                        const Text("Service Type",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),

                        Row(
                          children: serviceTypes.map((t) {
                            bool active = selectedServiceType == t;
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ChoiceChip(
                                label: Text(t),
                                selected: active,
                                selectedColor: Colors.blue,
                                labelStyle: TextStyle(
                                    color:
                                        active ? Colors.white : Colors.black),
                                onSelected: (_) {
                                  setState(() {
                                    selectedServiceType = t;
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 20),

                        // ---------------- SERVICE LIST DROPDOWN ----------------
                        const Text("Service List",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: const Text("Select Service"),
                              value: selectedService,
                              items: [
                                "General Electrical Repair",
                                'Fan Services',
                                'Light & LED Services',
                                'Heavy Load Electrical Work',
                                'Safety & Protection',
                                'Smart Home & Modern',
                                'Emergency Services'
                              ]
                                  .map((v) => DropdownMenuItem(
                                      value: v, child: Text(v)))
                                  .toList(),
                              onChanged: (v) =>
                                  setState(() => selectedService = v),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ---------------- SPECIFIC SERVICE ----------------
                        if (selectedService != null) ...[
                          const Text("Select Specific",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: generalElectrical.map((item) {
                                return RadioListTile(
                                  title: Text(item),
                                  secondary: Text(prices[item]!),
                                  value: item,
                                  groupValue: selectedSpecific,
                                  onChanged: (v) {
                                    setState(() => selectedSpecific = v);
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ],

                        const SizedBox(height: 20),

                        // ---------------- ADDRESS ----------------
                        const Text("Address",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10),

                        _textField(
                            "House 01, Block-D, Road 07, Mirpur 10, Dhaka-1216"),

                        const SizedBox(height: 15),

                        Row(
                          children: [
                            _addressCard(Icons.home, "Home"),
                            const SizedBox(width: 12),
                            _addressCard(Icons.work, "Work"),
                          ],
                        ),

                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            Icon(Icons.location_on_outlined, size: 20),
                            SizedBox(width: 6),
                            Text("Set location on Map"),
                          ],
                        ),

                        const SizedBox(height: 25),

                        // ---------------- SCHEDULE ----------------
                        const Text("Schedule",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 12),

                        Row(
                          children: [
                            _scheduleButton("Later", false),
                            const SizedBox(width: 12),
                            _scheduleButton("As soon as possible", true),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // ---------------- PROCEED BUTTON ----------------
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                second = true;
                              });
                              print(second);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text(
                              "Proceed",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
        ),
      ),
    );
  }

  // ---------------- WIDGET HELPERS ----------------

  Widget _stepCircle(String text, bool active) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: active ? Colors.blue : Colors.grey.shade300,
      child: Text(text,
          style: TextStyle(color: active ? Colors.white : Colors.black)),
    );
  }

  Widget _stepLine() {
    return Container(
      height: 2,
      width: 90,
      color: Colors.grey.shade400,
    );
  }

  Widget _textField(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(text),
    );
  }

  Widget _addressCard(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            Icon(icon, size: 28),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            const Text("Add post",
                style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _scheduleButton(String text, bool active) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: active ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: active ? Colors.blue : Colors.grey.shade400, width: 1.2),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: active ? Colors.blue : Colors.black, fontSize: 14),
          ),
        ),
      ),
    );
  }
}

Widget _serviceDetails(String title, String selection) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title), Text(selection)],
    ),
  );
}
