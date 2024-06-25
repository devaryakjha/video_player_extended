import 'package:equatable/equatable.dart';
import 'package:video_player_extended/src/common/controls_config.dart';
import 'package:video_player_extended/src/common/index.dart';

abstract class PlayerValue extends Equatable {
  const PlayerValue({
    this.isInitialised = false,
    this.aspectRatio,
    this.autoPlay = false,
    this.loop = false,
    this.thumbnail,
    this.controlsConfig = const ControlsConfig.defaults(),
  });

  const PlayerValue.uninitialized()
      : isInitialised = false,
        aspectRatio = null,
        autoPlay = false,
        loop = false,
        thumbnail = null,
        controlsConfig = const ControlsConfig.defaults();

  final bool isInitialised;

  final double? aspectRatio;

  final bool autoPlay;

  final bool loop;

  final ThumbnailConfig? thumbnail;

  final ControlsConfig controlsConfig;

  PlayerValue copyWith();

  @override
  List<Object?> get props =>
      [isInitialised, aspectRatio, autoPlay, loop, thumbnail, controlsConfig];
}
