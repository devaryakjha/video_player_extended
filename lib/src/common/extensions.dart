import 'package:flutter/widgets.dart';
import 'package:video_player_extended/src/common/base_controller.dart';
import 'package:video_player_extended/src/common/controller_provider.dart';

extension ReadControllerExtension on BuildContext {
  T readController<T extends PlayerController>() {
    return getInheritedWidgetOfExactType<VideoPlayerControllerProvider<T>>()!
        .controller;
  }
}

extension WatchControllerExtension on BuildContext {
  T watchController<T extends PlayerController>({Set<String>? aspect}) {
    return dependOnInheritedWidgetOfExactType<VideoPlayerControllerProvider<T>>(
            aspect: aspect)!
        .controller;
  }
}
