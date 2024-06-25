import 'package:video_player/video_player.dart';
import 'package:video_player_extended/src/common/base_controller.dart';

import 'video_player_value.dart';

final class RawVideoPlayerController
    extends PlayerController<RawVideoPlayerValue> {
  RawVideoPlayerController({
    required VideoPlayerController videoPlayerController,
  })  : _videoPlayerController = videoPlayerController,
        super(const RawVideoPlayerValue.uninitialized());

  final VideoPlayerController _videoPlayerController;

  @override
  VideoPlayerController get videoPlayerController => _videoPlayerController;
}
