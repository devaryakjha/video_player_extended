import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:video_player_extended/video_player_extended.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubePlayerController extends ValueNotifier<YoutubePlayerValue> {
  YoutubePlayerController(
    this.dataSource, {
    bool autoPlay = false,
  })  : _youtubeExplode = YoutubeExplode(),
        super(YoutubePlayerValue(autoPlay: autoPlay));

  final YoutubeExplode _youtubeExplode;
  late VideoPlayerController _videoPlayerController;

  VideoPlayerController get videoPlayerController => _videoPlayerController;

  /// The data source used to play the video.
  ///
  /// This can be a YouTube video ID or a YouTube video URL
  final String dataSource;

  final Completer<void> _initialiseCompleter = Completer<void>();

  /// Use this to determine if the controller has been initialised.
  ///
  /// If not wait for the [initialiseFuture] to complete.
  ///
  /// ```dart
  ///  Widget build(BuildContext context) {
  ///   return FutureBuilder(
  ///     future: controller.initialiseFuture,
  ///     builder: (context, snapshot) {
  ///       if (snapshot.connectionState == ConnectionState.done) {
  ///         return YoutubePlayer(controller: controller);
  ///       } else {
  ///         return CircularProgressIndicator();
  ///       }
  ///     },
  ///   );
  ///  }
  /// ```
  Future<void> get initialiseFuture => _initialiseCompleter.future;

  /// Initialises the controller.
  Future<void> initialise() async {
    _initialiseCompleter.complete(_initialise());
  }

  Future<void> _initialise() async {
    final streamInfo =
        await _youtubeExplode.videos.streamsClient.getManifest(dataSource);

    // Get the streams with both video and audio
    final allMuxed = streamInfo.muxed;
    final highestQuality = allMuxed.sortByVideoQuality().first;
    final videoUrl = highestQuality.url;
    final videos = allMuxed.map(YoutubeVideoInfo.fromMuxedStreamInfo).toList();

    _videoPlayerController = VideoPlayerController.networkUrl(videoUrl);
    await _videoPlayerController.initialize();

    if (value.autoPlay) await play();

    value = value.copyWith(videos: videos);
  }

  Future<void> play() => _videoPlayerController.play();
  Future<void> pause() => _videoPlayerController.pause();

  @override
  void dispose() {
    _youtubeExplode.close();
    super.dispose();
  }
}
