import 'dart:async';

import 'package:flutter/widgets.dart' show ValueNotifier;

import 'base_value.dart';

abstract class PlayerController<T extends PlayerValue>
    extends ValueNotifier<T> {
  PlayerController(super.value);

  /// Initializes the controller.
  FutureOr<void> init();
}
