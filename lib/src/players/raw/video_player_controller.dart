import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_extended/src/common/index.dart';

import 'video_player_value.dart';

final class RawVideoPlayerController
    extends PlayerController<RawVideoPlayerValue> {
  RawVideoPlayerController({
    required VideoPlayerController videoPlayerController,
    final bool? autoPlay,
    final bool? loop,
    final double? aspectRatio,
    final ThumbnailConfig? thumbnail,
  })  : _videoPlayerController = videoPlayerController,
        super(
          const RawVideoPlayerValue.uninitialized().copyWith(
            aspectRatio: aspectRatio,
            autoPlay: autoPlay,
            loop: loop,
            thumbnail: thumbnail,
          ),
        );

  final VideoPlayerController _videoPlayerController;

  @override
  VideoPlayerController get videoPlayerController => _videoPlayerController;

  @override
  Future<void> init() async {
    await super.init();
    Timer(const Duration(seconds: 3), initialised);
  }

  @override
  void initialised() async {
    value = value.copyWith(isInitialised: true);
    await setupOptions();
  }

  /// The key for the video player widget.
  ///
  /// helpful for animating the transition between thumbnail and video player.
  LocalKey get key => ValueKey(_videoPlayerController.dataSource);
}
