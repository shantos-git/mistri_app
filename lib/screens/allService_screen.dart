import 'package:flutter/material.dart';
import 'package:mistri_app/components/populerjob_grid.dart';

class AllservicePage extends StatelessWidget {
  const AllservicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 64,
            left: 24,
            right: 24,
          ),
          child: Column(
            children: [
              Text(
                "All Services",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Expanded(
                child: PopulerjobGrid(
                  item: 3,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
