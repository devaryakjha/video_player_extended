import 'package:flutter/widgets.dart' show InheritedWidget;
import 'package:video_player_extended/src/common/base_controller.dart';

class VideoPlayerControllerProvider<T extends PlayerController>
    extends InheritedWidget {
  const VideoPlayerControllerProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  final T controller;

  @override
  bool updateShouldNotify(VideoPlayerControllerProvider oldWidget) {
    return oldWidget.controller != controller;
  }
}
