import 'package:flutter/material.dart';
import 'package:minimalist_music_player/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class NeuromorphicSongTile extends StatelessWidget {
  final Widget? child;

  const NeuromorphicSongTile({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Check dark mode
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    Color darkShadow = isDarkMode ? Colors.black : Colors.grey.shade500;
    Color lightShadow = isDarkMode ? Colors.grey.shade900 : Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          // Dark shadow on bottom-right
          BoxShadow(
            color: darkShadow,
            offset: const Offset(4.0, 4.0),
            blurRadius: 15,
          ),
          // Light shadow on top-left
          BoxShadow(
            color: lightShadow,
            offset: const Offset(-4.0, -4.0),
            blurRadius: 15,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: child,
    );
  }
}
