import 'package:flutter/material.dart';
import '../../services/audio_manager.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final audioManager = AudioManager();

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
            listenable: audioManager,
            builder: (context, child) {
              final favorites = audioManager.favoriteSongs;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Play All Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Your Favorites",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${favorites.length} Liked Tracks",
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        if (favorites.isNotEmpty)
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00E5A8),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                            ),
                            icon: const Icon(Icons.play_arrow_rounded, size: 22),
                            label: const Text(
                              "Play All",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              audioManager.playSong(favorites.first);
                            },
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Favorites List
                  Expanded(
                    child: favorites.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.05),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.favorite_border_rounded,
                                    size: 64,
                                    color: Color(0xFFFF4D6D),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "No Favorite Songs Yet",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Tap the heart icon on any track to add it here!",
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.5),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 90),
                            itemCount: favorites.length,
                            itemBuilder: (context, index) {
                              final song = favorites[index];
                              final isCurrent =
                                  audioManager.currentSong.id == song.id;
                              final isPlaying =
                                  isCurrent && audioManager.isPlaying;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: isCurrent
                                      ? const Color(0xFF00E5A8)
                                          .withValues(alpha: 0.1)
                                      : Colors.white.withValues(alpha: 0.04),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: isCurrent
                                        ? const Color(0xFF00E5A8)
                                            .withValues(alpha: 0.3)
                                        : Colors.white.withValues(alpha: 0.05),
                                  ),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(16),
                                  child: ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        song.imagePath,
                                        width: 48,
                                        height: 48,
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
                                        fontSize: 16,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "${song.artist} • ${song.album}",
                                      style: TextStyle(
                                        color:
                                            Colors.white.withValues(alpha: 0.6),
                                        fontSize: 13,
                                      ),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.favorite_rounded,
                                            color: Color(0xFFFF4D6D),
                                          ),
                                          onPressed: () {
                                            audioManager.toggleFavorite(song);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            isPlaying
                                                ? Icons.pause_circle_filled_rounded
                                                : Icons.play_circle_fill_rounded,
                                            color: const Color(0xFF00E5A8),
                                            size: 34,
                                          ),
                                          onPressed: () {
                                            if (isCurrent) {
                                              audioManager.togglePlayPause();
                                            } else {
                                              audioManager.playSong(song);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      audioManager.playSong(song);
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