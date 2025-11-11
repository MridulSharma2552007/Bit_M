import 'package:bit_m/WIDGETS/bottom_music_tile.dart';
import 'package:bit_m/WIDGETS/navbar.dart';
import 'package:bit_m/roots/home.dart';
import 'package:bit_m/roots/playlist.dart';
import 'package:bit_m/roots/search.dart';
import 'package:bit_m/roots/settings.dart';
import 'package:bit_m/services/player_services.dart';
import 'package:flutter/material.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  final PlayerService _player = PlayerService();
  Map<String, dynamic>? _currentSong;
  bool isPlaying = false;
  int currentindex = 0;

  late final List<Widget> pages;
  void _onSongSelected(Map<String, dynamic> song) {
    setState(() {
      _currentSong = song;
      isPlaying = true;
    });
    _player.play(song['videoId']);
  }

  @override
  void initState() {
    super.initState();
    pages = [
      const Home(),
      Search(onSongSelected: _onSongSelected), // 👈 pass callback here
      const Playlist(),
      const Settings(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          pages[currentindex],
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: BottomMusicTile(
              title: _currentSong?['title'],
              channel: _currentSong?['channelTitle'],
              thumbnail: _currentSong?['thumbnailUrl'],
              videoId: _currentSong?['videoId'],
              onPlay: () {
                setState(() {
                  isPlaying = !isPlaying;
                });
              },
            ),
          ),
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
