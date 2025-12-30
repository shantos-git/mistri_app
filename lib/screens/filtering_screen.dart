import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mistri_app/components/filter_card.dart';
import 'package:mistri_app/components/my_button.dart';

class FilteringScreen extends StatelessWidget {
  List rating = [
    'Below 3',
    '3 - 3.5',
    '3.5 - 4',
    '4-4.5',
    'Above 4.5',
  ];

  List exp = [
    'Below 2 Years',
    '2 - 3 Y',
    '3 - 5 Y',
    '5 - 7 Y',
    'Above 7 Years+',
  ];

  List avail = [
    'Now',
    'Today',
    'Tomorrow',
  ];

  FilteringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.line_horizontal_3_decrease,
                          size: 32,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Filter',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Clear all',
                        style: TextStyle(
                          color: const Color(0xFF525252),
                          fontSize: 16,
                          fontFamily: 'Onest',
                          fontWeight: FontWeight.w500,
                          height: 1.50,
                          letterSpacing: -0.64,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 36,
                ),
                SizedBox(
                  width: 392,
                  child: Text(
                    'Rating',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Onest',
                      fontWeight: FontWeight.w500,
                      height: 1.33,
                      letterSpacing: -0.72,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 100,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1.7,
                    ),
                    itemCount: rating.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FilterCard(
                        index: index,
                        filterItem: rating,
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
                    'Price Range',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Onest',
                      fontWeight: FontWeight.w500,
                      height: 1.33,
                      letterSpacing: -0.72,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    // Expanded(
                    //   // child: MyTextfield(isPassword: false, hinttxt: '৳ 0',),
                    // ),
                    // Text('to'),
                    // Expanded(
                    //   // child: MyTextfield(isPassword: false, hinttxt: '৳ 5000'),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: 392,
                  child: Text(
                    'Location',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Onest',
                      fontWeight: FontWeight.w500,
                      height: 1.33,
                      letterSpacing: -0.72,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Select',
                          hintStyle: TextStyle(
                            color: const Color.fromARGB(255, 155, 155, 155),
                          ),
                        ),
                      ),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: [],
                        onChanged: (value) {},
                        icon: Icon(
                          CupertinoIcons.chevron_down,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: const Color.fromARGB(255, 161, 161, 161),
                ),
                SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: 392,
                  child: Text(
                    'Experience Level',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Onest',
                      fontWeight: FontWeight.w500,
                      height: 1.33,
                      letterSpacing: -0.72,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 100,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1.7,
                    ),
                    itemCount: exp.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FilterCard(
                        index: index,
                        filterItem: exp,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 36,
                ),
                SizedBox(
                  width: 392,
                  child: Text(
                    'Availabilty',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Onest',
                      fontWeight: FontWeight.w500,
                      height: 1.33,
                      letterSpacing: -0.72,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 100,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: avail.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FilterCard(
                        index: index,
                        filterItem: avail,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                MyButton(btntxt: 'Apply Filter', onClick: () {}),
                SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
