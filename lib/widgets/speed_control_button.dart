import 'package:flutter/material.dart';
import 'package:learning_audio/providers/song_providers.dart';
import 'package:provider/provider.dart';

class SpeedControlButton extends StatefulWidget {
  const SpeedControlButton({super.key});

  @override
  State<SpeedControlButton> createState() => _SpeedControlButtonState();
}

class _SpeedControlButtonState extends State<SpeedControlButton> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  final List<double> speeds = [
    0.25,
    0.5,
    0.75,
    1.0,
    1.25,
    1.5,
    1.75,
    2.0,
  ];

  void _toggleOverlay() {
    if (_overlayEntry == null) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _showOverlay() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: 60,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: const Offset(-10, -180), // Posisi overlay
            child: Material(
              color: Colors.transparent,
              child: Container(
                height: 160, // Batasi tinggi agar scrollable
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Consumer<SongProvider>(
                  builder: (context, songProvider, _) {
                    return ListView.builder(
                      itemCount: speeds.length,
                      reverse: true, // Tampilkan dari 2.0 ke 0.25
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      itemBuilder: (context, index) {
                        final speed = speeds[index];
                        final isSelected = speed == songProvider.speed;
                        return GestureDetector(
                          onTap: () {
                            songProvider.setSpeed(speed);
                            _removeOverlay();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 8),
                            color: isSelected
                                ? Colors.white.withOpacity(0.2)
                                : Colors.transparent,
                            child: Center(
                              child: Text(
                                '${speed}x',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: IconButton(
        icon: const Icon(
          Icons.speed,
          color: Colors.white,
          size: 35,
        ),
        onPressed: _toggleOverlay,
      ),
    );
  }
}
