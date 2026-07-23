import 'package:flutter/material.dart';

class MusicNoteAnimation extends StatefulWidget {
  const MusicNoteAnimation({super.key});

  @override
  State<MusicNoteAnimation> createState() => _MusicNoteAnimationState();
}

class _MusicNoteAnimationState extends State<MusicNoteAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _animation = Tween<double>(
      begin: 0,
      end: -60,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: Opacity(
            opacity: 0.8,
            child: const Icon(
              Icons.music_note,
              color: Color(0xFF00C896),
              size: 24,
            ),
          ),
        );
      },
    );
  }
}