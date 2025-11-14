import 'package:bit_m/services/youtube_services.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final Function(Map<String, dynamic>) onSongSelected;
  const Search({super.key, required this.onSongSelected});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool _loading = false;
  final TextEditingController _searchController = TextEditingController();
  final YouTubeService _youTubeService = YouTubeService();
  List<Map<String, dynamic>> _searchResults = [];

  int? _selectedIndex;

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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
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
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onSubmitted: (_) {
                    _performingSearch();
                    setState(() {
                      _selectedIndex = null;
                    });
                  },
                ),
              ),

              // 🎵 Results list
              Expanded(
                child: _loading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final video = _searchResults[index];
                          final bool isSelected = _selectedIndex == index;

                          return GestureDetector(
                            onTap: () {
                              widget.onSongSelected(video);
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.deepPurple.withOpacity(0.3)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                onLongPress: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text('Saved to Favorites'),
                                    ),
                                  );
                                },

                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    video['thumbnailUrl'],
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(
                                  video['title'],
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  "${video['channelTitle']} • ${video['duration']}",
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
