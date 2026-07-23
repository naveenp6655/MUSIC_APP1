import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchBarWidget({
    super.key,
    required this.onChanged,
    this.hintText = "Search songs, artists...",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
        ),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(0xFF00E5A8),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
          ),
        ),
      ),
    );
  }
}
