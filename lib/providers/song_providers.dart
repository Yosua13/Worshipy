import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:learning_audio/models/song.dart';

class SongProvider with ChangeNotifier {
  final AudioPlayer audioPlayer = AudioPlayer();
  Song? _currentSong;
  bool _isPlaying = false;

  Song? get currentSong => _currentSong;
  bool get isPlaying => _isPlaying;

  double _volume = 1.0;
  double get volume => _volume;

  // double _speed = 1.0;
  // double get speed => _speed;

  // void setSpeed(double value) {
  //   _speed = value;
  //   audioPlayer.setSpeed(value);
  //   notifyListeners();
  // }

  void setVolume(double value) {
    _volume = value;
    audioPlayer.setVolume(value);
    notifyListeners();
  }

  Future<void> setSong(Song song) async {
    _currentSong = song;
    await audioPlayer.setUrl(song.url);
    play();
    notifyListeners();
  }

  void play() {
    audioPlayer.play();
    _isPlaying = true;
    notifyListeners();
  }

  void pause() {
    audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void togglePlayPause() {
    if (_isPlaying) {
      pause();
    } else {
      play();
    }
  }

  Future<void> seekRelative(Duration offset) async {
    final current = audioPlayer.position;
    final newPosition = current + offset;
    final duration = audioPlayer.duration ?? Duration.zero;
    audioPlayer.seek(
      newPosition < Duration.zero
          ? Duration.zero
          : newPosition > duration
              ? duration
              : newPosition,
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
