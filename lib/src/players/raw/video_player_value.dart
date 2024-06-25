import 'package:flutter/widgets.dart';

import '../../common/base_value.dart';

@immutable
final class RawVideoPlayerValue extends PlayerValue {
  const RawVideoPlayerValue({
    super.isInitialised,
  });

  const RawVideoPlayerValue.uninitialized() : super.uninitialized();
}
