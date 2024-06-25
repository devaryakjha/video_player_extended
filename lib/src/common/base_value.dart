import 'package:flutter/widgets.dart' show immutable;

@immutable
abstract class PlayerValue {
  const PlayerValue({
    this.isInitialised = false,
    this.aspectRatio,
  });

  const PlayerValue.uninitialized()
      : isInitialised = false,
        aspectRatio = null;

  final bool isInitialised;

  final double? aspectRatio;

  PlayerValue copyWith();
}
