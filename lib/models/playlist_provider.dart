import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:minimalist_music_player/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  // Playlist of songs
  final List<Song> _playlist = [
    Song(
      songName: "Humble",
      artistName: "Kendrick Lamar",
      albumImagePath: "assets/images/DAMN.jpeg",
      audioPath: "assets/audio/TestMusic.mp3",
    ),
    Song(
      songName: "Crocodile Tearz",
      artistName: "J. Cole",
      albumImagePath: "assets/images/MDL.jpg",
      audioPath: "assets/audio/TestMusic.mp3",
    ),
    Song(
      songName: "Reincarnated",
      artistName: "Kendrick Lamar",
      albumImagePath: "assets/images/GNX.png",
      audioPath: "assets/audio/TestMusic.mp3",
    ),
    Song(
      songName: "For the Night",
      artistName: "Pop Smoke",
      albumImagePath: "assets/images/SFTS.jpg",
      audioPath: "assets/audio/TestMusic.mp3",
    ),
    Song(
      songName: "Runaway",
      artistName: "Kanye West",
      albumImagePath: "assets/images/MBDTF.png",
      audioPath: "assets/audio/TestMusic.mp3",
    ),
    Song(
      songName: "Low Life",
      artistName: "Future",
      albumImagePath: "assets/images/EVOL.jpg",
      audioPath: "assets/audio/TestMusic.mp3",
    ),
    Song(
      songName: "Alright",
      artistName: "Kendrick Lamar",
      albumImagePath: "assets/images/TPAB.png",
      audioPath: "assets/audio/TestMusic.mp3",
    ),
    Song(
      songName: "Starboy",
      artistName: "The Weeknd",
      albumImagePath: "assets/images/Starboy.png",
      audioPath: "assets/audio/TestMusic.mp3",
    ),
    Song(
      songName: "My Eyes",
      artistName: "Travis Scott",
      albumImagePath: "assets/images/Utopia.jpg",
      audioPath: "assets/audio/TestMusic.mp3",
    ),
    Song(
      songName: "Rent Money",
      artistName: "Future",
      albumImagePath: "assets/images/FUTURE.jpg",
      audioPath: "assets/audio/TestMusic.mp3",
    ),
  ];

  // Current song index
  int? _currentSongIndex = 0;

  /* Audio Player */

  // Audio Player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // Constructor
  PlaylistProvider() {
    listenToDuration();
  }

  // Initially not playing
  bool _isPlaying = false;

  // Play song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    // Stop the current song
    await _audioPlayer.stop();
    // Play the new song
    await _audioPlayer.play(AssetSource(path.replaceFirst('assets/', '')));
    // Update values
    _isPlaying = true;
    notifyListeners();
  }

  // Pause song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // Resume song
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // Pause or resume
  void pauseOrResume() async => _isPlaying ? pause() : resume();

  // Seek to a specific position
  void seekTo(Duration position) async => await _audioPlayer.seek(position);

  // Play next song
  void playNextSong() {
    if (_currentSongIndex == null) return;

    // Check if there is a next song
    if (_currentSongIndex! < _playlist.length - 1) {
      // Increment the current song index
      _currentSongIndex = _currentSongIndex! + 1;
    }
    // Loop back to the first song
    else {
      _currentSongIndex = 0;
    }
    // Play the new song
    play();
  }

  // Play previous song
  void playPreviousSong() async {
    if (_currentSongIndex == null) return;

    // If currently playing, restart song
    if (_currentDuration.inSeconds > 3) {
      await _audioPlayer.seek(Duration.zero);
      return;
    }

    // Check if there is a previous song
    if (_currentSongIndex! > 0) {
      // Decrement the current song index
      _currentSongIndex = _currentSongIndex! - 1;
    }
    // Loop back to the last song
    else {
      _currentSongIndex = _playlist.length - 1;
    }
    // Play the new song
    play();
  }

  // Listen to durations
  void listenToDuration() {
    // Listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    // Listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    // Listen for song Completion
    _audioPlayer.onPlayerComplete.listen((event) => playNextSong());
  }

  // Dispose audio player
  void disposeAudioPlayer() {
    _audioPlayer.dispose();
    super.dispose();
  }

  /* Getters */
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  /* Setters */
  set currentSongIndex(int? newIndex) {
    // Set the new current song index
    _currentSongIndex = newIndex;

    // Play the new song
    if (newIndex != null) play();

    // Update the UI
    notifyListeners();
  }
}
