import 'package:bit_m/colors/app_colors.dart';
import 'package:flutter/material.dart';

class BottomMusicTile extends StatefulWidget {
  const BottomMusicTile({super.key});

  @override
  State<BottomMusicTile> createState() => _BottomMusicTileState();
}

class _BottomMusicTileState extends State<BottomMusicTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 70,
          width: double.infinity,

          decoration: BoxDecoration(
            color: AppColors.primaryBgColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Song Title - Artist Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.play_arrow, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.skip_next, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
