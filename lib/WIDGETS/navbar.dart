import 'dart:ui';

import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),

        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withOpacity(0.6),
                width: 1,
              ),
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _builderIcon(IconData icon, bool isSelected) {
  return Icon(icon, color: isSelected ? Colors.white : Colors.black, size: 30);
}
