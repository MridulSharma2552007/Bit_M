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
        borderRadius: BorderRadius.circular(20),
        
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.person, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
