import 'package:flutter/material.dart';

import '../screens/home/home_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/player/player_screen.dart';
import '../screens/favorite/favorite_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../widgets/mini_player.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(onOpenPlayer: () => _onItemTapped(2)),
      const SearchScreen(),
      const PlayerScreen(),
      const FavoriteScreen(),
      const SettingsScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),
          if (_selectedIndex != 2)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: MiniPlayer(
                onTap: () => _onItemTapped(2),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF0D1B2A),
          selectedItemColor: const Color(0xFF00E5A8),
          unselectedItemColor: Colors.white.withValues(alpha: 0.5),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 10,
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
        ),
      ),
    );
  }
}