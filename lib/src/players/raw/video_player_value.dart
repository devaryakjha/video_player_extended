import 'package:flutter/widgets.dart';

import '../../common/base_value.dart';

@immutable
final class RawVideoPlayerValue extends PlayerValue {
  const RawVideoPlayerValue({
    super.isInitialised,
    super.aspectRatio,
  });

  const RawVideoPlayerValue.uninitialized() : super.uninitialized();

  @override
  RawVideoPlayerValue copyWith({
    bool? isInitialised,
    double? aspectRatio,
  }) {
    return RawVideoPlayerValue(
      isInitialised: isInitialised ?? this.isInitialised,
      aspectRatio: aspectRatio ?? this.aspectRatio,
    );
  }
}
