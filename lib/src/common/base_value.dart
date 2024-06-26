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
    this.hideControls = true,
  });

  const PlayerValue.uninitialized()
      : isInitialised = false,
        aspectRatio = null,
        autoPlay = false,
        loop = false,
        thumbnail = null,
        controlsConfig = const ControlsConfig.defaults(),
        hideControls = true;

  final bool isInitialised;

  final double? aspectRatio;

  final bool autoPlay;

  final bool loop;

  final ThumbnailConfig? thumbnail;

  final ControlsConfig controlsConfig;

  final bool hideControls;

  PlayerValue copyWith();

  @override
  List<Object?> get props => [
        isInitialised,
        aspectRatio,
        autoPlay,
        loop,
        thumbnail,
        controlsConfig,
        hideControls,
      ];

  bool shouldNotifySelectors(Set<String> aspects, PlayerValue other) {
    if (aspects.contains('isInitialised') &&
        isInitialised != other.isInitialised) {
      return true;
    }
    if (aspects.contains('aspectRatio') && aspectRatio != other.aspectRatio) {
      return true;
    }
    if (aspects.contains('autoPlay') && autoPlay != other.autoPlay) {
      return true;
    }
    if (aspects.contains('loop') && loop != other.loop) {
      return true;
    }
    if (aspects.contains('thumbnail') && thumbnail != other.thumbnail) {
      return true;
    }
    if (aspects.contains('controlsConfig') &&
        controlsConfig != other.controlsConfig) {
      return true;
    }
    if (aspects.contains('hideControls') &&
        hideControls != other.hideControls) {
      return true;
    }
    return false;
  }
}
