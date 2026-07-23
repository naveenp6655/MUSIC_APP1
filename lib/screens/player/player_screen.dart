import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../services/audio_manager.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  final AudioManager _audioManager = AudioManager();

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    );

    if (_audioManager.isPlaying) {
      _rotationController.repeat();
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
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
              Color(0xFF050B14),
            ],
          ),
        ),
        child: SafeArea(
          child: ListenableBuilder(
            listenable: _audioManager,
            builder: (context, child) {
              final song = _audioManager.currentSong;
              final isPlaying = _audioManager.isPlaying;

              if (isPlaying) {
                if (!_rotationController.isAnimating) {
                  _rotationController.repeat();
                }
              } else {
                if (_rotationController.isAnimating) {
                  _rotationController.stop();
                }
              }

              double sliderValue = _audioManager.position.inSeconds.toDouble();
              double maxSlider = _audioManager.duration.inSeconds.toDouble();
              if (maxSlider <= 0 || sliderValue > maxSlider) {
                maxSlider = song.duration.inSeconds.toDouble();
                sliderValue = sliderValue.clamp(0.0, maxSlider);
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Column(
                  children: [
                    // Header Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                        Column(
                          children: const [
                            Text(
                              "NOW PLAYING",
                              style: TextStyle(
                                color: Color(0xFF00E5A8),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Classic Tamil Collection",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            song.isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: song.isFavorite
                                ? const Color(0xFFFF4D6D)
                                : Colors.white70,
                          ),
                          onPressed: () {
                            _audioManager.toggleFavorite(song);
                          },
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Vinyl / CD Disc Player Widget
                    Center(
                      child: AnimatedBuilder(
                        animation: _rotationController,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _rotationController.value * 2 * math.pi,
                            child: child,
                          );
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Outer Vinyl Ring
                            Container(
                              width: 260,
                              height: 260,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF111111),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF00E5A8)
                                        .withValues(alpha: 0.25),
                                    blurRadius: 30,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                            // Vinyl Grooves
                            Container(
                              width: 230,
                              height: 230,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.08),
                                  width: 12,
                                ),
                              ),
                            ),
                            // Album Art Center
                            Hero(
                              tag: 'song_art_${song.id}',
                              child: ClipOval(
                                child: Image.asset(
                                  song.imagePath,
                                  width: 140,
                                  height: 140,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Center Spindle Hole
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0D1B2A),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white70,
                                  width: 3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Song Info
                    Text(
                      song.title,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "${song.artist} • ${song.album}",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Progress Slider
                    SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 4,
                        activeTrackColor: const Color(0xFF00E5A8),
                        inactiveTrackColor: Colors.white.withValues(alpha: 0.15),
                        thumbColor: const Color(0xFF00E5A8),
                        thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 6),
                        overlayColor:
                            const Color(0xFF00E5A8).withValues(alpha: 0.2),
                      ),
                      child: Slider(
                        value: sliderValue,
                        min: 0.0,
                        max: maxSlider,
                        onChanged: (value) {
                          _audioManager
                              .seek(Duration(seconds: value.toInt()));
                        },
                      ),
                    ),

                    // Time Stamps
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(_audioManager.position),
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            _formatDuration(_audioManager.duration > Duration.zero
                                ? _audioManager.duration
                                : song.duration),
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Playback Controls Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Shuffle Button
                        IconButton(
                          icon: Icon(
                            Icons.shuffle_rounded,
                            color: _audioManager.isShuffle
                                ? const Color(0xFF00E5A8)
                                : Colors.white.withValues(alpha: 0.4),
                          ),
                          onPressed: () {
                            _audioManager.toggleShuffle();
                          },
                        ),
                        // Skip Previous
                        IconButton(
                          iconSize: 40,
                          icon: const Icon(
                            Icons.skip_previous_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _audioManager.previousSong();
                          },
                        ),
                        // Play / Pause Circle Button
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF00E5A8), Color(0xFF00B4D8)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF00E5A8)
                                    .withValues(alpha: 0.4),
                                blurRadius: 20,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: IconButton(
                            iconSize: 38,
                            icon: Icon(
                              isPlaying
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              _audioManager.togglePlayPause();
                            },
                          ),
                        ),
                        // Skip Next
                        IconButton(
                          iconSize: 40,
                          icon: const Icon(
                            Icons.skip_next_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _audioManager.nextSong();
                          },
                        ),
                        // Repeat Button
                        IconButton(
                          icon: Icon(
                            _audioManager.repeatMode == MusicRepeatMode.one
                                ? Icons.repeat_one_rounded
                                : Icons.repeat_rounded,
                            color: _audioManager.repeatMode != MusicRepeatMode.off
                                ? const Color(0xFF00E5A8)
                                : Colors.white.withValues(alpha: 0.4),
                          ),
                          onPressed: () {
                            _audioManager.toggleRepeat();
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Equalizer Visualizer Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        12,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 2.5),
                          width: 4,
                          height: isPlaying
                              ? (15 + (index * 7) % 25).toDouble()
                              : 6,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00E5A8),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}