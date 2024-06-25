import 'dart:async';

import 'package:flutter/widgets.dart' show ValueNotifier, mustCallSuper;
import 'package:video_player_extended/video_player_extended.dart';

import 'base_value.dart';

abstract class PlayerController<T extends PlayerValue>
    extends ValueNotifier<T> {
  PlayerController(super.value);

  /// Initializes the controller.
  @mustCallSuper
  Future<void> init() async {
    await videoPlayerController.initialize();
    videoPlayerController.addListener(_listener);
  }

  Future<void> setupOptions() async {
    if (value.loop) {
      await videoPlayerController.setLooping(true);
    }
  }

  Future<void> play() => videoPlayerController.play();

  Future<void> pause() => videoPlayerController.pause();

  Future<void> seekTo(Duration position) =>
      videoPlayerController.seekTo(position);

  /// Called when the controller is initialised.
  void initialised();

  @override
  FutureOr<void> dispose() {
    videoPlayerController
      ..removeListener(_listener)
      ..dispose();
    super.dispose();
  }

  VideoPlayerController get videoPlayerController;

  /// effective value of the aspect ratio.
  ///
  /// either user provided or the original aspect ratio of the video.
  double get aspectRatio =>
      value.aspectRatio ?? videoPlayerController.value.aspectRatio;

  void _listener() {
    notifyListeners();
  }

  /// The duration of the video.
  Duration get duration;

  /// The current position of the video.
  Duration get position;

  /// The buffered duration of the video.
  Duration get buffered => Duration.zero;

  bool get isPlaying => videoPlayerController.value.isPlaying;

  bool get isFinished => position >= duration;

  void showControls();

  void hideControls();
}
