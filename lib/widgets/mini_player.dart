import 'dart:ui';
import 'package:flutter/material.dart';
import '../services/audio_manager.dart';

class MiniPlayer extends StatelessWidget {
  final VoidCallback onTap;

  const MiniPlayer({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final audioManager = AudioManager();

    return ListenableBuilder(
      listenable: audioManager,
      builder: (context, child) {
        final currentSong = audioManager.currentSong;
        final isPlaying = audioManager.isPlaying;

        double progress = 0.0;
        if (audioManager.duration.inMilliseconds > 0) {
          progress = (audioManager.position.inMilliseconds /
                  audioManager.duration.inMilliseconds)
              .clamp(0.0, 1.0);
        }

        return GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  height: 68,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B263B).withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Progress Bar Top Indicator
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.transparent,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF00E5A8),
                        ),
                        minHeight: 2.5,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
                            children: [
                              // Song Album Thumbnail
                              Hero(
                                tag: 'song_art_${currentSong.id}',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    currentSong.imagePath,
                                    width: 44,
                                    height: 44,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),

                              // Song Title & Artist
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentSong.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      currentSong.artist,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha: 0.7),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Controls
                              IconButton(
                                icon: Icon(
                                  isPlaying
                                      ? Icons.pause_circle_filled
                                      : Icons.play_circle_fill,
                                  color: const Color(0xFF00E5A8),
                                  size: 36,
                                ),
                                onPressed: () {
                                  audioManager.togglePlayPause();
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.skip_next_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {
                                  audioManager.nextSong();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
