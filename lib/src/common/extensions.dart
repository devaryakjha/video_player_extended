import 'package:collection/collection.dart';
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
  T watchController<T extends PlayerController>() {
    return dependOnInheritedWidgetOfExactType<
            VideoPlayerControllerProvider<T>>()!
        .controller;
  }
}

extension SelectControllerExtension on BuildContext {
  R selectControllerValues<T extends PlayerController, R>(
      R Function(T value) selector) {
    final provider =
        getInheritedWidgetOfExactType<VideoPlayerControllerProvider<T>>();
    final controller = provider?.controller;
    if (controller == null) {
      throw FlutterError('Controller not found');
    }

    final selected = selector(controller);
    if (provider != null) {
      dependOnInheritedWidgetOfExactType<VideoPlayerControllerProvider<T>>(
          aspect: (T? newValue) {
        if (newValue is! T) {
          throw FlutterError('Controller type mismatch');
        }

        return !const DeepCollectionEquality()
            .equals(selector(newValue), selected);
      });
    }

    return selected;
  }
}
