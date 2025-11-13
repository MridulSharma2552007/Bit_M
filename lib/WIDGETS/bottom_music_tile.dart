import 'package:bit_m/WIDGETS/fullplayer.dart';
import 'package:bit_m/colors/app_colors.dart';
import 'package:bit_m/services/player_services.dart';
import 'package:flutter/material.dart';

class BottomMusicTile extends StatelessWidget {
  final String? title;
  final String? channel;
  final String? thumbnail;
  final String? videoId;
  final VoidCallback? onPlay;
  final String? duration;
  BottomMusicTile({
    super.key,
    this.title,
    this.channel,
    this.thumbnail,
    this.videoId,
    this.onPlay,
    this.duration,
  });
  final PlayerService player = PlayerService();

  @override
  Widget build(BuildContext context) {
    if (title == null || videoId == null) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 71,
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
                borderRadius: BorderRadius.circular(10),
                image: thumbnail != null
                    ? DecorationImage(
                        image: NetworkImage(thumbnail!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),

            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Fullplayer(
                      title: '$title',
                      artist: '$channel',
                      thumbnailUrl: '$thumbnail',
                      duration: '$duration',
                      player: player,
                    ),
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                  );
                },
                child: Text(
                  '$title - $channel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.play_arrow, color: Colors.white),
              onPressed: onPlay,
            ),
            IconButton(
              icon: const Icon(Icons.skip_next, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
