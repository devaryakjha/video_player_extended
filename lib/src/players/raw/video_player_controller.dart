import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_extended/src/common/controls_config.dart';
import 'package:video_player_extended/src/common/index.dart';

import 'video_player_value.dart';

class RawVideoPlayerController extends PlayerController<RawVideoPlayerValue> {
  RawVideoPlayerController({
    required VideoPlayerController videoPlayerController,
    final bool? autoPlay,
    final bool? loop,
    final double? aspectRatio,
    final ThumbnailConfig? thumbnail,
    final ControlsConfig? controlsConfig,
    final bool controlsVisibleByDefault = false,
    this.autoHideControlsDuration = const Duration(seconds: 3),
  })  : _videoPlayerController = videoPlayerController,
        super(
          const RawVideoPlayerValue.uninitialized().copyWith(
            aspectRatio: aspectRatio,
            autoPlay: autoPlay,
            loop: loop,
            thumbnail: thumbnail,
            controlsConfig: controlsConfig,
            hideControls: !controlsVisibleByDefault,
          ),
        );

  final VideoPlayerController _videoPlayerController;

  final Duration autoHideControlsDuration;

  @override
  VideoPlayerController get videoPlayerController => _videoPlayerController;

  @override
  Future<void> init() async {
    await super.init();
    initialised();
  }

  @override
  void initialised() async {
    await setupOptions();
    value = value.copyWith(isInitialised: true);
    if (value.autoPlay) await play();
  }

  /// The key for the video player widget.
  ///
  /// helpful for animating the transition between thumbnail and video player.
  LocalKey get key => ValueKey(_videoPlayerController.dataSource);

  @override
  Duration get duration => _videoPlayerController.value.duration;

  @override
  Duration get position => _videoPlayerController.value.position;

  @override
  Duration get buffered => _videoPlayerController.value.buffered.isEmpty
      ? Duration.zero
      : _videoPlayerController.value.buffered.last.end;

  @override
  void showControls() {
    value = value.copyWith(hideControls: false);
  }

  @override
  void hideControls() {
    value = value.copyWith(hideControls: true);
  }
}
