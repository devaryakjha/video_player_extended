import 'package:flutter/widgets.dart';
import 'package:video_player_extended/video_player_extended.dart';

abstract class VideoPlayerControllerBase<T> extends ValueNotifier<T> {
  VideoPlayerControllerBase(super.value);

  /// Skips forward by the specified [duration].
  Future<void> skipForward(Duration duration);

  /// Skips backward by the specified [duration].
  Future<void> skipBackward(Duration duration);

  Future<void> seekTo(Duration position);

  Duration get duration;
  Duration get position;
  Duration get buffered;

  VideoPlayerController get videoPlayerController;
}
