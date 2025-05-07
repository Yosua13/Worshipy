import 'package:flutter/material.dart';
import 'package:learning_audio/models/song.dart';
import 'package:learning_audio/widgets/song_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Worshipy'),
      ),
      body: SongList(songs: songs),
    );
  }
}
