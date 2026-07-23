import 'package:flutter/material.dart';
import '../../services/audio_manager.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final AudioManager _audioManager = AudioManager();
  String _searchQuery = "";

  final List<String> _quickTags = [
    "Ilaiyaraaja",
    "Deva",
    "SPB",
    "KJ Yesudas",
    "Melody",
    "Thalapathi",
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1B263B),
              Color(0xFF0D1B2A),
            ],
          ),
        ),
        child: SafeArea(
          child: ListenableBuilder(
            listenable: _audioManager,
            builder: (context, child) {
              final allSongs = _audioManager.playlist;
              final filteredSongs = allSongs.where((song) {
                final query = _searchQuery.toLowerCase();
                return song.title.toLowerCase().contains(query) ||
                    song.artist.toLowerCase().contains(query) ||
                    song.album.toLowerCase().contains(query) ||
                    song.category.toLowerCase().contains(query);
              }).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Header
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 16, 20, 12),
                    child: Text(
                      "Search Songs",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Search Bar Input Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.12),
                        ),
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(color: Colors.white),
                        onChanged: (val) {
                          setState(() {
                            _searchQuery = val;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: Color(0xFF00E5A8),
                          ),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.clear_rounded,
                                    color: Colors.white54,
                                  ),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() {
                                      _searchQuery = "";
                                    });
                                  },
                                )
                              : null,
                          hintText: "Search title, artist, or album...",
                          hintStyle: TextStyle(
                            color: Colors.white.withValues(alpha: 0.4),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Quick Tag Chips
                  SizedBox(
                    height: 38,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _quickTags.length,
                      itemBuilder: (context, index) {
                        final tag = _quickTags[index];
                        final isSelected = _searchQuery == tag;

                        return GestureDetector(
                          onTap: () {
                            _searchController.text = tag;
                            setState(() {
                              _searchQuery = tag;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF00E5A8)
                                  : const Color(0xFF1B263B),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF00E5A8)
                                    : Colors.white.withValues(alpha: 0.15),
                              ),
                            ),
                            child: Text(
                              "#$tag",
                              style: TextStyle(
                                color: isSelected ? Colors.black : Colors.white,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Results Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      _searchQuery.isEmpty
                          ? "All Tracks (${allSongs.length})"
                          : "Results (${filteredSongs.length})",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Results List
                  Expanded(
                    child: filteredSongs.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off_rounded,
                                  size: 60,
                                  color: Colors.white.withValues(alpha: 0.2),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  "No songs found matching '$_searchQuery'",
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.5),
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 90),
                            itemCount: filteredSongs.length,
                            itemBuilder: (context, index) {
                              final song = filteredSongs[index];
                              final isCurrent =
                                  _audioManager.currentSong.id == song.id;
                              final isPlaying =
                                  isCurrent && _audioManager.isPlaying;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.04),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(14),
                                  child: ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        song.imagePath,
                                        width: 44,
                                        height: 44,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title: Text(
                                      song.title,
                                      style: TextStyle(
                                        color: isCurrent
                                            ? const Color(0xFF00E5A8)
                                            : Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "${song.artist} • ${song.album}",
                                      style: TextStyle(
                                        color:
                                            Colors.white.withValues(alpha: 0.6),
                                        fontSize: 12,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(
                                        isPlaying
                                            ? Icons.pause_circle_filled_rounded
                                            : Icons.play_circle_fill_rounded,
                                        color: const Color(0xFF00E5A8),
                                        size: 32,
                                      ),
                                      onPressed: () {
                                        if (isCurrent) {
                                          _audioManager.togglePlayPause();
                                        } else {
                                          _audioManager.playSong(song);
                                        }
                                      },
                                    ),
                                    onTap: () {
                                      _audioManager.playSong(song);
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}