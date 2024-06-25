import 'dart:async';

import 'package:flutter/widgets.dart' show ValueNotifier, mustCallSuper;
import 'package:video_player_extended/video_player_extended.dart';

import 'base_value.dart';

abstract class PlayerController<T extends PlayerValue>
    extends ValueNotifier<T> {
  PlayerController(super.value);

  /// Initializes the controller.
  @mustCallSuper
  FutureOr<void> init() {
    videoPlayerController.addListener(_listener);
  }

  @override
  FutureOr<void> dispose() {
    videoPlayerController.removeListener(_listener);
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
}
