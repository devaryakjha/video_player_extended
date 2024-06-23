// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

@immutable
class YoutubePlayerValue {
  const YoutubePlayerValue({
    this.videos = const [],
    this.autoPlay = false,
  });

  final List<YoutubeVideoInfo> videos;
  final bool autoPlay;

  @override
  String toString() {
    return '(videos: $videos)';
  }

  @override
  int get hashCode => Object.hashAll([videos, autoPlay]);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is YoutubePlayerValue &&
        listEquals(other.videos, videos) &&
        other.autoPlay == autoPlay;
  }

  YoutubePlayerValue copyWith({
    List<YoutubeVideoInfo>? videos,
    bool? autoPlay,
  }) {
    return YoutubePlayerValue(
      videos: videos ?? this.videos,
      autoPlay: autoPlay ?? this.autoPlay,
    );
  }
}

@immutable
class YoutubeVideoInfo {
  const YoutubeVideoInfo({
    required this.qualityLabel,
    required this.quality,
    required this.url,
  });

  final String qualityLabel;
  final VideoQuality quality;
  final Uri url;

  factory YoutubeVideoInfo.fromMuxedStreamInfo(MuxedStreamInfo streamInfo) {
    return YoutubeVideoInfo(
      qualityLabel: streamInfo.qualityLabel,
      url: streamInfo.url,
      quality: streamInfo.videoQuality,
    );
  }

  @override
  String toString() {
    return '(qualityLabel: $qualityLabel, url: $url, quality: $quality)';
  }

  @override
  int get hashCode => Object.hashAll([qualityLabel, url, quality]);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is YoutubeVideoInfo &&
        other.qualityLabel == qualityLabel &&
        other.url == url &&
        other.quality == quality;
  }
}
