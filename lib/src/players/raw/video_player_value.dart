import 'package:video_player_extended/src/common/index.dart';

final class RawVideoPlayerValue extends PlayerValue {
  const RawVideoPlayerValue({
    super.isInitialised,
    super.aspectRatio,
    super.autoPlay,
    super.loop,
    super.thumbnail,
  });

  const RawVideoPlayerValue.uninitialized() : super.uninitialized();

  @override
  RawVideoPlayerValue copyWith({
    bool? isInitialised,
    double? aspectRatio,
    bool? autoPlay,
    bool? loop,
    ThumbnailConfig? thumbnail,
  }) {
    return RawVideoPlayerValue(
      isInitialised: isInitialised ?? this.isInitialised,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      autoPlay: autoPlay ?? this.autoPlay,
      loop: loop ?? this.loop,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  @override
  List<Object?> get props => [...super.props];
}
