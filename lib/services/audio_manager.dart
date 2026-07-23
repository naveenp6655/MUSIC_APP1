import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/song_model.dart';

enum MusicRepeatMode { off, all, one }

class AudioManager extends ChangeNotifier {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;

  final AudioPlayer _player = AudioPlayer();

  final List<SongModel> _playlist = List.from(sampleSongs);
  int _currentIndex = 0;
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  bool _isShuffle = false;
  MusicRepeatMode _repeatMode = MusicRepeatMode.off;

  AudioManager._internal() {
    _initListeners();
  }

  void _initListeners() {
    _player.onPlayerStateChanged.listen((state) {
      _isPlaying = state == PlayerState.playing;
      notifyListeners();
    });

    _player.onPositionChanged.listen((pos) {
      _position = pos;
      notifyListeners();
    });

    _player.onDurationChanged.listen((dur) {
      _duration = dur;
      notifyListeners();
    });

    _player.onPlayerComplete.listen((_) {
      _handleSongComplete();
    });
  }

  // Getters
  List<SongModel> get playlist => _playlist;
  int get currentIndex => _currentIndex;
  SongModel get currentSong => _playlist[_currentIndex];
  bool get isPlaying => _isPlaying;
  Duration get position => _position;
  Duration get duration => _duration;
  bool get isShuffle => _isShuffle;
  MusicRepeatMode get repeatMode => _repeatMode;
  List<SongModel> get favoriteSongs =>
      _playlist.where((s) => s.isFavorite).toList();

  // Playback Control Methods
  Future<void> playSong(SongModel song) async {
    final index = _playlist.indexWhere((s) => s.id == song.id);
    if (index != -1) {
      await playAtIndex(index);
    }
  }

  Future<void> playAtIndex(int index) async {
    if (index < 0 || index >= _playlist.length) return;

    _currentIndex = index;
    notifyListeners();

    try {
      await _player.stop();
      await _player.play(AssetSource(currentSong.audioPath));
      _isPlaying = true;
    } catch (e) {
      debugPrint("Audio Play Error: $e");
    }
    notifyListeners();
  }

  Future<void> togglePlayPause() async {
    if (_isPlaying) {
      await _player.pause();
    } else {
      if (_position > Duration.zero && _position < _duration) {
        await _player.resume();
      } else {
        await _player.play(AssetSource(currentSong.audioPath));
      }
    }
  }

  Future<void> seek(Duration pos) async {
    await _player.seek(pos);
  }

  Future<void> nextSong() async {
    if (_isShuffle) {
      int nextIndex = (_currentIndex + 1) % _playlist.length;
      await playAtIndex(nextIndex);
    } else {
      int nextIndex = (_currentIndex + 1) % _playlist.length;
      await playAtIndex(nextIndex);
    }
  }

  Future<void> previousSong() async {
    int prevIndex = (_currentIndex - 1 + _playlist.length) % _playlist.length;
    await playAtIndex(prevIndex);
  }

  void toggleShuffle() {
    _isShuffle = !_isShuffle;
    notifyListeners();
  }

  void toggleRepeat() {
    if (_repeatMode == MusicRepeatMode.off) {
      _repeatMode = MusicRepeatMode.all;
    } else if (_repeatMode == MusicRepeatMode.all) {
      _repeatMode = MusicRepeatMode.one;
    } else {
      _repeatMode = MusicRepeatMode.off;
    }
    notifyListeners();
  }

  void toggleFavorite(SongModel song) {
    final index = _playlist.indexWhere((s) => s.id == song.id);
    if (index != -1) {
      _playlist[index].isFavorite = !_playlist[index].isFavorite;
      notifyListeners();
    }
  }

  void _handleSongComplete() {
    if (_repeatMode == MusicRepeatMode.one) {
      playAtIndex(_currentIndex);
    } else if (_repeatMode == MusicRepeatMode.all || _currentIndex < _playlist.length - 1) {
      nextSong();
    } else {
      _isPlaying = false;
      _position = Duration.zero;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
