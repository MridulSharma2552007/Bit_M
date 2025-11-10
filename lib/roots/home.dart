import 'package:bit_m/colors/app_colors.dart';
import 'package:bit_m/roots/search.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple, Color(0xFF000000)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TopFullTray(),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Hey There 👋',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryBgColor,
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopFullTray extends StatelessWidget {
  const TopFullTray({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UpperTray(imgPath: 'lib/assets/Images/user.png', icon: null),
        Spacer(),
        UpperTray(
          imgPath: null,
          icon: Icons.search,
          ontap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Search()),
          ),
        ),
        SizedBox(width: 20),
        UpperTray(imgPath: null, icon: Icons.bubble_chart),
      ],
    );
  }
}

class UpperTray extends StatefulWidget {
  final String? imgPath;
  final IconData? icon;
  final VoidCallback? ontap;
  const UpperTray({
    super.key,
    required this.imgPath,
    this.ontap,
    required this.icon,
  });

  @override
  State<UpperTray> createState() => _UpperTrayState();
}

class _UpperTrayState extends State<UpperTray> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white.withValues(alpha: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget.imgPath != null
              ? Image.asset(widget.imgPath!)
              : Icon(widget.icon, color: Colors.white.withValues(alpha: 0.5)),
        ),
      ),
    );
  }
}
