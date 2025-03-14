import 'package:flutter/material.dart';
import 'package:minimalist_music_player/components/my_drawer.dart';
import 'package:minimalist_music_player/models/playlist_provider.dart';
import 'package:minimalist_music_player/models/song.dart';
import 'package:minimalist_music_player/pages/song_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Get playlist provider
  late final dynamic playlistProvider;

  // Initialize the playlist provider
  @override
  void initState() {
    super.initState();
    // Get the Playlist Provider
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  // Go to a song
  void goToSong(int songIndex) {
    // Set the current song index
    playlistProvider.currentSongIndex = songIndex;

    // Navigate to the song page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SongPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: Text("PLAYLIST"), centerTitle: true),
      drawer: const MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          // Get the Playlist
          final List<Song> playlist = value.playlist;

          // Return List View UI
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              // Get the Song
              final Song song = playlist[index];

              // Return ListTile
              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Image.asset(song.albumImagePath),
                onTap: () => goToSong(index),
              );
            },
          );
        },
      ),
    );
  }
}
