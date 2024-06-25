import 'package:flutter/widgets.dart' show immutable;

@immutable
abstract class PlayerValue {
  const PlayerValue({
    this.isInitialised = false,
  });

  const PlayerValue.uninitialized() : isInitialised = false;

  final bool isInitialised;
}
