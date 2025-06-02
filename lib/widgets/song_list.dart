import 'package:flutter/material.dart';
import 'package:learning_audio/models/song.dart';
import 'package:learning_audio/providers/song_providers.dart';
import 'package:learning_audio/screens/player_screen.dart';
import 'package:provider/provider.dart';

class SongList extends StatefulWidget {
  final List<Song> mp3;
  final TextEditingController searchController;

  const SongList({
    super.key,
    required this.mp3,
    required this.searchController,
  });

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  List<Song> _filteredSongs = [];

  void _onSearchChanged() {
    _applyFilter();
  }

  void _applyFilter() {
    String query = widget.searchController.text.toLowerCase();
    setState(() {
      _filteredSongs = widget.mp3
          .where((song) =>
              song.title.toLowerCase().contains(query) ||
              song.artist.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(_onSearchChanged);
    _applyFilter();
  }

  @override
  void dispose() {
    widget.searchController.removeListener(_onSearchChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _filteredSongs.length,
      itemBuilder: (context, index) {
        final song = _filteredSongs[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${index + 1}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: "Satoshi",
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
            style: const TextStyle(
              fontFamily: "Satoshi",
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFFD6D6D6),
            ),
          ),
          subtitle: Text(
            song.artist,
            style: TextStyle(
              color: Color(0xFFD6D6D6),
              fontSize: 12,
            ),
          ),
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
