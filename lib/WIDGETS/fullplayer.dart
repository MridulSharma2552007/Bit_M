import 'package:flutter/material.dart';

class Fullplayer extends StatefulWidget {
  final String title;
  final String artist;
  final String thumbnailUrl;
  const Fullplayer({
    super.key,
    required this.title,
    required this.artist,
    required this.thumbnailUrl,
  });

  @override
  State<Fullplayer> createState() => _FullplayerState();
}

class _FullplayerState extends State<Fullplayer> {
  double _currentSliderValue = 0;
  final double _songDuration = 200;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Color(0xFF121212),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                widget.thumbnailUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.artist,
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                  Slider(
                    value: _currentSliderValue,
                    min: 0,
                    max: _songDuration,
                    onChanged: (value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.skip_previous, color: Colors.white),
                        iconSize: 40,
                        onPressed: () {},
                      ),
                      SizedBox(width: 30),
                      IconButton(
                        icon: Icon(Icons.play_arrow, color: Colors.white),
                        iconSize: 60,
                        onPressed: () {},
                      ),
                      SizedBox(width: 30),
                      IconButton(
                        icon: Icon(Icons.skip_next, color: Colors.white),
                        iconSize: 40,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
