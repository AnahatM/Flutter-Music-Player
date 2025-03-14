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

  /* Getters */
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;

  /* Setters */
  set currentSongIndex(int? newIndex) {
    // Set the new current song index
    _currentSongIndex = newIndex;
    // Update the UI
    notifyListeners();
  }
}
