import 'package:flutter/material.dart';
import 'package:minimalist_music_player/components/neuromorphic_box.dart';
import 'package:minimalist_music_player/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  // Format Duration
  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        // Get Playlist
        final playlist = value.playlist;

        // Get Current Song from Index
        final currentSong = playlist[value.currentSongIndex ?? 0];

        // Return Song Page Scaffold UI
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 24.0,
                top: 12.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Custom App Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back Button
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),

                      // Song Title
                      const Text("PLAYLIST"),

                      // Overflow Menu
                      IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 24.0),

                  // Album Artwork
                  NeuromorphicBox(
                    child: Column(
                      children: [
                        // Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(currentSong.albumImagePath),
                        ),

                        // Song, Artist Name, and Icon
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Song and Artist Name
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentSong.songName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(currentSong.artistName),
                                ],
                              ),

                              // Heart Icon
                              Icon(Icons.favorite, color: Colors.red),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24.0),

                  // Song Duration Progress
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Start Time
                            Text(formatDuration(value.currentDuration)),
                            // Shuffle Icon
                            Icon(Icons.shuffle),
                            // Repeat Icon
                            Icon(Icons.repeat),
                            // End Time
                            Text(formatDuration(value.totalDuration)),
                          ],
                        ),
                      ),

                      // Progress Bar
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 0,
                          ),
                        ),
                        child: Slider(
                          min: 0,
                          max: value.totalDuration.inSeconds.toDouble(),
                          value: value.currentDuration.inSeconds.toDouble(),
                          activeColor: Colors.green,
                          inactiveColor: Colors.grey.shade400,
                          onChanged: (double double) {
                            // During when the user is sliding around
                          },
                          onChangeEnd: (double double) {
                            // When the user stops sliding
                            value.seekTo(Duration(seconds: double.toInt()));
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24.0),

                  // Playback Controls
                  Row(
                    children: [
                      // Previous Button
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playPreviousSong,
                          child: NeuromorphicBox(
                            child: Icon(Icons.skip_previous),
                          ),
                        ),
                      ),

                      const SizedBox(width: 20.0),

                      // Play / Pause Button
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: value.pauseOrResume,
                          child: NeuromorphicBox(
                            child: Icon(
                              value.isPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 20.0),

                      // Next Button
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playNextSong,
                          child: NeuromorphicBox(child: Icon(Icons.skip_next)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
