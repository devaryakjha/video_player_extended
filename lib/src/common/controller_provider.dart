import 'package:flutter/widgets.dart' show InheritedModel;
import 'package:video_player_extended/src/common/base_controller.dart';

class VideoPlayerControllerProvider<T extends PlayerController>
    extends InheritedModel<String> {
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

  @override
  bool updateShouldNotifyDependent(
    covariant VideoPlayerControllerProvider oldWidget,
    Set<String> dependencies,
  ) {
    return oldWidget.controller.value
        .shouldNotifySelectors(dependencies, controller.value);
  }
}
