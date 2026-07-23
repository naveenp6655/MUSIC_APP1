import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _equalizerPreset = "Bass Boost";
  String _sleepTimer = "Off";
  String _audioQuality = "High (320 kbps)";

  final List<String> _eqPresets = [
    "Normal",
    "Bass Boost",
    "Vocal",
    "Treble",
    "Jazz",
    "Rock"
  ];

  final List<String> _timerOptions = [
    "Off",
    "15 Minutes",
    "30 Minutes",
    "60 Minutes"
  ];

  final List<String> _qualityOptions = [
    "High (320 kbps)",
    "Medium (192 kbps)",
    "Low (128 kbps)"
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
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              // Header
              const Text(
                "Settings",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Customize audio quality, equalizer & preferences",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 25),

              // Audio Settings Section
              _buildSectionTitle("AUDIO & EQUALIZER"),
              const SizedBox(height: 10),
              _buildDropdownTile(
                icon: Icons.equalizer_rounded,
                title: "Equalizer Preset",
                subtitle: _equalizerPreset,
                value: _equalizerPreset,
                items: _eqPresets,
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _equalizerPreset = val;
                    });
                  }
                },
              ),
              const SizedBox(height: 10),
              _buildDropdownTile(
                icon: Icons.high_quality_rounded,
                title: "Audio Streaming Quality",
                subtitle: _audioQuality,
                value: _audioQuality,
                items: _qualityOptions,
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _audioQuality = val;
                    });
                  }
                },
              ),

              const SizedBox(height: 25),

              // Playback & Sleep Section
              _buildSectionTitle("PLAYBACK & TIMERS"),
              const SizedBox(height: 10),
              _buildDropdownTile(
                icon: Icons.timer_rounded,
                title: "Sleep Timer",
                subtitle: _sleepTimer == "Off"
                    ? "Timer inactive"
                    : "Stop music in $_sleepTimer",
                value: _sleepTimer,
                items: _timerOptions,
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _sleepTimer = val;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(val == "Off"
                            ? "Sleep timer turned off"
                            : "Sleep timer set to $val"),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ),

              const SizedBox(height: 25),

              // About & Information Section
              _buildSectionTitle("ABOUT APP"),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00E5A8).withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.music_note_rounded,
                            color: Color(0xFF00E5A8),
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "நிம்மதி Music App",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Version 1.0.0 • Professional Edition",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(height: 24, color: Colors.white12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Designed for Tamil Music Lovers",
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        Icon(
                          Icons.favorite_rounded,
                          color: Color(0xFFFF4D6D),
                          size: 18,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF00E5A8),
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildDropdownTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 12,
            ),
          ),
          trailing: DropdownButton<String>(
            value: value,
            dropdownColor: const Color(0xFF1B263B),
            underline: const SizedBox(),
            icon: const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF00E5A8)),
            style: const TextStyle(
              color: Color(0xFF00E5A8),
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            onChanged: onChanged,
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}