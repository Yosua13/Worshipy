import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:learning_audio/providers/song_providers.dart';
import 'package:provider/provider.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    final songProvider = Provider.of<SongProvider>(context, listen: false);
    audioPlayer = songProvider.audioPlayer;
    isPlaying = songProvider.isPlaying;
  }

  String _formatDuration(Duration? duration) {
    if (duration == null) return "0:00";
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final songProvider = Provider.of<SongProvider>(context);
    final song = songProvider.currentSong;

    if (song == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('No Song Selected')),
        body: const Center(child: Text('Please select a song.')),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // title: Text(
        //   song.title,
        //   style: const TextStyle(color: Colors.white),
        // ),
      ),
      body: Stack(
        children: [
          // Full screen image
          SizedBox.expand(
            child: Image.network(
              song.coverUrl,
              fit: BoxFit.fill,
            ),
          ),

          // Gradient overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black87,
                  Colors.black,
                ],
              ),
            ),
          ),

          // UI content
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        song.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        song.artist,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      StreamBuilder<Duration>(
                        stream: audioPlayer.positionStream,
                        builder: (context, snapshot) {
                          final position = snapshot.data ?? Duration.zero;
                          final duration =
                              audioPlayer.duration ?? Duration.zero;

                          return Column(
                            children: [
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: Colors.white,
                                  inactiveTrackColor: Colors.grey.shade500,
                                  trackHeight: 2.0,
                                  thumbColor: Colors.white,
                                  thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 5.0),
                                  overlayColor: Colors.white.withAlpha(32),
                                  overlayShape: const RoundSliderOverlayShape(
                                      overlayRadius: 0.0),
                                ),
                                child: Slider(
                                  min: 0,
                                  max: duration.inMilliseconds.toDouble(),
                                  value: position.inMilliseconds
                                      .clamp(0, duration.inMilliseconds)
                                      .toDouble(),
                                  onChanged: (value) {
                                    audioPlayer.seek(
                                        Duration(milliseconds: value.toInt()));
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6.0, top: 6.0),
                                    child: Text(
                                      _formatDuration(position),
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 6.0, top: .0),
                                    child: Text(
                                      _formatDuration(duration),
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      // const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.replay_5,
                              size: 40,
                              color: Colors.white,
                            ),
                            onPressed: () => songProvider
                                .seekRelative(const Duration(seconds: -5)),
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            icon: Icon(
                              songProvider.isPlaying
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_fill,
                              size: 75,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              songProvider.togglePlayPause();
                            },
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            icon: const Icon(
                              Icons.forward_5,
                              size: 40,
                              color: Colors.white,
                            ),
                            onPressed: () => songProvider
                                .seekRelative(const Duration(seconds: 5)),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
