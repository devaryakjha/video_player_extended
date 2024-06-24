import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_extended/src/common/models/video_control_options.dart';
import 'package:video_player_extended/src/common/video_player_controller_base.dart';

import 'video_controls.dart';

class VideoPlayerBase extends StatelessWidget {
  const VideoPlayerBase({
    super.key,
    this.aspectRatio = 16 / 9,
    required this.controller,
    this.videoControlOptions,
  });

  final double aspectRatio;
  final VideoPlayerControllerBase controller;
  final VideoControlOptions? videoControlOptions;

  @override
  Widget build(BuildContext context) {
    final child = Stack(
      alignment: Alignment.bottomCenter,
      children: [
        VideoPlayer(controller.videoPlayerController),
        VideoControls(controller, options: videoControlOptions),
      ],
    );

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: child,
    );
  }
}
