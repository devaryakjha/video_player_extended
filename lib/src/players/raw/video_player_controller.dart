import 'dart:async';

import 'package:video_player_extended/src/common/base_controller.dart';

import 'video_player_value.dart';

final class RawVideoPlayerController
    extends PlayerController<RawVideoPlayerValue> {
  RawVideoPlayerController() : super(const RawVideoPlayerValue.uninitialized());

  @override
  FutureOr<void> init() {}
}
