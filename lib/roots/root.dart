import 'package:bit_m/WIDGETS/bottom_music_tile.dart';
import 'package:bit_m/WIDGETS/navbar.dart';
import 'package:bit_m/roots/home.dart';
import 'package:bit_m/roots/playlist.dart';
import 'package:bit_m/roots/search.dart';
import 'package:bit_m/roots/settings.dart';
import 'package:flutter/material.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  bool isPlaying = false;
  int currentindex = 0;
  final List<Widget> pages = [Home(), Search(), Playlist(), Settings()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          pages[currentindex],
          Positioned(bottom: 80, left: 0, right: 0, child: BottomMusicTile()),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Navbar(
              currentindex: currentindex,
              onTapItem: (index) {
                setState(() {
                  currentindex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
