import 'package:bit_m/WIDGETS/navbar.dart';
import 'package:bit_m/colors/app_colors.dart';
import 'package:flutter/material.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primaryBlue, AppColors.primaryBgColor],
          ),
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}
