import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF0D1B2A),
      selectedItemColor: const Color(0xFF00E5A8),
      unselectedItemColor: Colors.white.withValues(alpha: 0.5),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.music_note_rounded),
          label: "Player",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_rounded),
          label: "Favorites",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_rounded),
          label: "Settings",
        ),
      ],
    );
  }
}
