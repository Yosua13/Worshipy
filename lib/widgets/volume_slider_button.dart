import 'package:flutter/material.dart';
import 'package:learning_audio/providers/song_providers.dart';
import 'package:provider/provider.dart';

class VolumeSliderButton extends StatefulWidget {
  const VolumeSliderButton({super.key});

  @override
  State<VolumeSliderButton> createState() => _VolumeSliderButtonState();
}

class _VolumeSliderButtonState extends State<VolumeSliderButton> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  bool isOverlayVisible = false;

  void _toggleOverlay() {
    if (isOverlayVisible) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 50,
        height: 185,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, -210),
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Consumer<SongProvider>(
                builder: (context, songProvider, _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Teks volume
                      Text(
                        '${(songProvider.volume * 100).round()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 140,
                        child: RotatedBox(
                          quarterTurns: -1,
                          child: Slider(
                            min: 0.01,
                            max: 1.0,
                            divisions: 99,
                            value: songProvider.volume.clamp(0.01, 1.0),
                            onChanged: (value) {
                              songProvider.setVolume(value);
                            },
                            activeColor: Colors.white,
                            inactiveColor: Colors.grey.shade700,
                            thumbColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() => isOverlayVisible = true);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => isOverlayVisible = false);
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
          Icons.volume_up,
          color: Colors.white,
          size: 35,
        ),
        onPressed: _toggleOverlay,
      ),
    );
  }
}
