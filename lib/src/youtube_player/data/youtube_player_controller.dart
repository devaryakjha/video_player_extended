import 'dart:async';

import 'package:video_player_extended/src/common/video_player_controller_base.dart';
import 'package:video_player_extended/video_player_extended.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubePlayerController
    extends VideoPlayerControllerBase<YoutubePlayerValue> {
  YoutubePlayerController(
    this.dataSource, {
    bool autoPlay = false,
  })  : _youtubeExplode = YoutubeExplode(),
        super(YoutubePlayerValue(autoPlay: autoPlay));

  final YoutubeExplode _youtubeExplode;
  late VideoPlayerController _videoPlayerController;

  @override
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
    await _initialiseCompleter.future;
  }

  Future<void> _initialise() async {
    final streamInfo =
        await _youtubeExplode.videos.streamsClient.getManifest(dataSource);

    // Get the streams with both video and audio
    final allMuxed = streamInfo.muxed;
    final highestQuality = allMuxed.sortByVideoQuality().first;
    final videoUrl = highestQuality.url;

    _videoPlayerController = VideoPlayerController.networkUrl(videoUrl);
    _setuplisteners();

    final videos = allMuxed.map(YoutubeVideoInfo.fromMuxedStreamInfo).toList();

    await _videoPlayerController.initialize();

    if (value.autoPlay) await play();

    value = value.copyWith(videos: videos);
  }

  void _setuplisteners() {
    _videoPlayerController.addListener(notifyListeners);
  }

  void _removeListeners() {
    _videoPlayerController.removeListener(notifyListeners);
  }

  Future<void> play() => _videoPlayerController.play();
  Future<void> pause() => _videoPlayerController.pause();

  @override
  void dispose() {
    pause();
    _removeListeners();
    _videoPlayerController.dispose();
    _youtubeExplode.close();
    super.dispose();
  }

  @override
  Future<void> skipBackward(Duration duration) {
    final newPosition = _videoPlayerController.value.position - duration;
    return _videoPlayerController.seekTo(newPosition);
  }

  @override
  Future<void> skipForward(Duration duration) {
    final newPosition = _videoPlayerController.value.position + duration;
    return _videoPlayerController.seekTo(newPosition);
  }

  @override
  Duration get duration => _videoPlayerController.value.duration;

  @override
  Duration get position => _videoPlayerController.value.position;

  @override
  Duration get buffered => _videoPlayerController.value.buffered.last.end;

  @override
  Future<void> seekTo(Duration position) {
    return _videoPlayerController.seekTo(position);
  }
}
