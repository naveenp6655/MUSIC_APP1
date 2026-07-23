import 'package:flutter/material.dart';
import '../models/song_model.dart';

class MusicCard extends StatelessWidget {
  final SongModel song;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const MusicCard({
    super.key,
    required this.song,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
          onTap: onTap,
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          subtitle: Text(
            "${song.artist} • ${song.album}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 12,
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              song.isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: song.isFavorite
                  ? const Color(0xFFFF4D6D)
                  : Colors.white.withValues(alpha: 0.4),
            ),
            onPressed: onFavoriteToggle,
          ),
        ),
      ),
    );
  }
}
