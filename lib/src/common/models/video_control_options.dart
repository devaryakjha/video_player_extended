import 'package:flutter/material.dart';

@immutable
class VideoControlOptions {
  const VideoControlOptions({
    this.allowScrubbing = true,
    this.showProgressIndicator = true,
    this.showCaption = true,
    this.autoHideDuration = const Duration(seconds: 3),
  });

  final bool allowScrubbing;
  final bool showProgressIndicator;
  final bool showCaption;
  final Duration autoHideDuration;

  VideoControlOptions copyWith({
    bool? allowScrubbing,
    bool? showProgressIndicator,
    bool? showCaption,
    Duration? autoHideDuration,
  }) {
    return VideoControlOptions(
      allowScrubbing: allowScrubbing ?? this.allowScrubbing,
      showProgressIndicator:
          showProgressIndicator ?? this.showProgressIndicator,
      showCaption: showCaption ?? this.showCaption,
      autoHideDuration: autoHideDuration ?? this.autoHideDuration,
    );
  }

  @override
  String toString() {
    return '(allowScrubbing: $allowScrubbing, showProgressIndicator: $showProgressIndicator, showCaption: $showCaption, autoHideDuration: $autoHideDuration)';
  }

  @override
  int get hashCode => Object.hashAll([
        allowScrubbing,
        showProgressIndicator,
        showCaption,
        autoHideDuration,
      ]);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VideoControlOptions &&
        other.allowScrubbing == allowScrubbing &&
        other.showProgressIndicator == showProgressIndicator &&
        other.showCaption == showCaption &&
        other.autoHideDuration == autoHideDuration;
  }
}
