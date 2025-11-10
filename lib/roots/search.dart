import 'package:bit_m/services/player_Services.dart';
import 'package:bit_m/services/youtube_services.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool _loading = false;
  final PlayerService _playerService = PlayerService();
  final TextEditingController _searchController = TextEditingController();
  final YouTubeService _youTubeService = YouTubeService();
  List<Map<String, dynamic>> _searchResults = [];

  void _performingSearch() async {
    if (_searchController.text.isEmpty) return;
    setState(() {
      _loading = true;
    });
    try {
      final videos = await _youTubeService.fetchVideoDetails(
        _searchController.text,
      );
      setState(() {
        _searchResults = videos;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF000000), Color(0xFF203A43)],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: TextStyle(color: Colors.white),
                onSubmitted: (value) => _performingSearch(),
              ),
            ),
            Expanded(
              child: _loading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final video = _searchResults[index];
                        return GestureDetector(
                          onTap: () {
                            print("🎬 Playing videoId: ${video['videoId']}");
                            _playerService.play(video['videoId']);
                          },
                          child: ListTile(
                            leading: Image.network(video['thumbnailUrl']),
                            title: Text(
                              video['title'],
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              video['channelTitle'],
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
