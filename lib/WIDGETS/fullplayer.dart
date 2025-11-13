import 'package:flutter/material.dart';

class Fullplayer extends StatefulWidget {
  final String title;
  final String artist;
  final String thumbnailUrl;
  final String duration;

  const Fullplayer({
    super.key,
    required this.title,
    required this.artist,
    required this.thumbnailUrl,
    required this.duration,
  });

  @override
  State<Fullplayer> createState() => _FullplayerState();
}

class _FullplayerState extends State<Fullplayer> {
  double _currentSliderValue = 0;
  late double _songDuration;

  @override
  void initState() {
    super.initState();
    _songDuration = durationToSeconds(widget.duration).toDouble();
  }

  int durationToSeconds(String duration) {
    final parts = duration.split(":");
    final minutes = int.parse(parts[0]);
    final seconds = int.parse(parts[1]);
    return minutes * 60 + seconds;
  }

  String formatSeconds(double sec) {
    final minutes = (sec ~/ 60).toString().padLeft(2, '0');
    final seconds = (sec % 60).toInt().toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

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
          const SizedBox(height: 25),

          /// --- ARTWORK ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                widget.thumbnailUrl,
                height: 310,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 40),

          /// --- SONG TITLE ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 8),

          /// --- ARTIST ---
          Text(
            widget.artist,
            style: const TextStyle(color: Colors.white70, fontSize: 17),
          ),

          const SizedBox(height: 20),

          /// --- SLIDER + TIME ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.deepPurpleAccent,
                    inactiveTrackColor: Colors.white24,
                    thumbColor: Colors.white,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 7,
                    ),
                    overlayShape: SliderComponentShape.noOverlay,
                  ),
                  child: Slider(
                    value: _currentSliderValue,
                    min: 0,
                    max: _songDuration,
                    onChanged: (value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                  ),
                ),

                /// --- TIME ROW ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatSeconds(_currentSliderValue),
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Text(
                      widget.duration,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 35),

          /// --- CONTROLS ---
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous, color: Colors.white),
                iconSize: 42,
                onPressed: () {},
              ),
              const SizedBox(width: 25),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white10,
                ),
                child: IconButton(
                  icon: const Icon(Icons.play_arrow, color: Colors.white),
                  iconSize: 55,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 25),
              IconButton(
                icon: const Icon(Icons.skip_next, color: Colors.white),
                iconSize: 42,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
