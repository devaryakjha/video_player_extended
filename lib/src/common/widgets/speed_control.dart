import 'package:flutter/material.dart';
import 'package:video_player_extended/src/common/video_player_controller_base.dart';

class SpeedControl extends StatefulWidget {
  const SpeedControl(this.controller, {super.key});

  final VideoPlayerControllerBase controller;

  @override
  State<SpeedControl> createState() => _SpeedControlState();
}

class _SpeedControlState extends State<SpeedControl> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: 'Playback speed',
      initialValue: widget.controller.videoPlayerController.value.playbackSpeed,
      onSelected: widget.controller.videoPlayerController.setPlaybackSpeed,
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: 0.5,
            child: Text('0.5x'),
          ),
          const PopupMenuItem(
            value: 0.75,
            child: Text('0.75x'),
          ),
          const PopupMenuItem(
            value: 1.0,
            child: Text('1.0x'),
          ),
          const PopupMenuItem(
            value: 1.25,
            child: Text('1.25x'),
          ),
          const PopupMenuItem(
            value: 1.5,
            child: Text('1.5x'),
          ),
        ];
      },
      child: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Icon(Icons.speed),
      ),
    );
  }
}
