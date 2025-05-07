import 'package:flutter/material.dart';
import 'package:learning_audio/models/song.dart';
import 'package:learning_audio/providers/song_providers.dart';
import 'package:learning_audio/screens/player_screen.dart';
import 'package:provider/provider.dart';

class SongList extends StatelessWidget {
  final List<Song> songs;

  const SongList({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${index + 1}',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 12),
              ClipRRect(
                child: Image.network(
                  song.coverUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      width: 60,
                      height: 60,
                      child: Center(child: Icon(Icons.error)),
                    );
                  },
                ),
              ),
            ],
          ),
          title: Text(
            song.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(song.artist),
          onTap: () {
            Provider.of<SongProvider>(context, listen: false).setSong(song);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PlayerScreen()),
            );
          },
        );
      },
    );
  }
}
