import 'package:flutter/material.dart';
import '../../models/song_model.dart';
import '../../services/audio_manager.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onOpenPlayer;

  const HomeScreen({
    super.key,
    required this.onOpenPlayer,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = "All Songs";
  final AudioManager _audioManager = AudioManager();

  final List<String> _categories = [
    "All Songs",
    "Ilaiyaraaja Hits",
    "Deva Magic",
    "90s Classics",
    "Melodies",
  ];

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
              Color(0xFF0A1118),
            ],
          ),
        ),
        child: SafeArea(
          child: ListenableBuilder(
            listenable: _audioManager,
            builder: (context, child) {
              List<SongModel> songs = _audioManager.playlist;
              if (_selectedCategory != "All Songs") {
                songs = songs
                    .where((s) => s.category == _selectedCategory)
                    .toList();
              }

              return CustomScrollView(
                slivers: [
                  // App Header
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Text(
                                    "நிம்மதி ",
                                    style: TextStyle(
                                      color: Color(0xFF00E5A8),
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "MUSIC",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Feel the rhythm of classic Tamil hits",
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.08),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.notifications_none_rounded,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("No new notifications"),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Featured Artists Banner
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Featured Legends",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 130,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              children: [
                                _buildArtistCard(
                                  name: "Ilaiyaraaja",
                                  tag: "Isaignani",
                                  imagePath: "assets/image/raja.png",
                                  onTap: () {
                                    setState(() {
                                      _selectedCategory = "Ilaiyaraaja Hits";
                                    });
                                  },
                                ),
                                _buildArtistCard(
                                  name: "Deva",
                                  tag: "Thenisai Thendral",
                                  imagePath: "assets/image/deva.png",
                                  onTap: () {
                                    setState(() {
                                      _selectedCategory = "Deva Magic";
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Category Filter Horizontal Chips
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 42,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          final category = _categories[index];
                          final isSelected = category == _selectedCategory;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              decoration: BoxDecoration(
                                gradient: isSelected
                                    ? const LinearGradient(
                                        colors: [
                                          Color(0xFF00E5A8),
                                          Color(0xFF00B4D8),
                                        ],
                                      )
                                    : null,
                                color: isSelected
                                    ? null
                                    : const Color(0xFF1B263B),
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF00E5A8)
                                      : Colors.white.withValues(alpha: 0.15),
                                  width: 1.5,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: const Color(0xFF00E5A8)
                                              .withValues(alpha: 0.4),
                                          blurRadius: 10,
                                          offset: const Offset(0, 3),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  color: isSelected
                                      ? const Color(0xFF050B14)
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Track List Header
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
                      child: Text(
                        "Popular Tracks",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Songs List
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 90),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final song = songs[index];
                          final isCurrent =
                              _audioManager.currentSong.id == song.id;
                          final isPlaying =
                              isCurrent && _audioManager.isPlaying;

                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: isCurrent
                                  ? const Color(0xFF00E5A8)
                                      .withValues(alpha: 0.12)
                                  : Colors.white.withValues(alpha: 0.04),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isCurrent
                                    ? const Color(0xFF00E5A8)
                                        .withValues(alpha: 0.4)
                                    : Colors.white.withValues(alpha: 0.06),
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 4),
                                leading: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        song.imagePath,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    if (isPlaying)
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Icon(
                                          Icons.graphic_eq_rounded,
                                          color: Color(0xFF00E5A8),
                                          size: 28,
                                        ),
                                      ),
                                  ],
                                ),
                                title: Text(
                                  song.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: isCurrent
                                        ? const Color(0xFF00E5A8)
                                        : Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Text(
                                  "${song.artist} • ${song.album}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.6),
                                    fontSize: 13,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        song.isFavorite
                                            ? Icons.favorite_rounded
                                            : Icons.favorite_border_rounded,
                                        color: song.isFavorite
                                            ? const Color(0xFFFF4D6D)
                                            : Colors.white.withValues(alpha: 0.4),
                                      ),
                                      onPressed: () {
                                        _audioManager.toggleFavorite(song);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        isPlaying
                                            ? Icons.pause_circle_filled_rounded
                                            : Icons.play_circle_fill_rounded,
                                        color: const Color(0xFF00E5A8),
                                        size: 36,
                                      ),
                                      onPressed: () {
                                        if (isCurrent) {
                                          _audioManager.togglePlayPause();
                                        } else {
                                          _audioManager.playSong(song);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  if (isCurrent) {
                                    widget.onOpenPlayer();
                                  } else {
                                    _audioManager.playSong(song);
                                  }
                                },
                              ),
                            ),
                          );
                        },
                        childCount: songs.length,
                      ),
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

  Widget _buildArtistCard({
    required String name,
    required String tag,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.1),
              Colors.white.withValues(alpha: 0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                imagePath,
                width: 54,
                height: 54,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    tag,
                    style: TextStyle(
                      color: const Color(0xFF00E5A8),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}