import 'package:video_player_extended/src/common/index.dart';
import 'package:video_player_extended/src/players/raw/index.dart';
import 'package:video_player_extended/video_player_extended.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubePlayerController extends PlayerController<RawVideoPlayerValue> {
  YoutubePlayerController({
    required this.videoId,
  }) : super(const RawVideoPlayerValue.uninitialized());

  final String videoId;

  ThumbnailConfig get thumbnail => ThumbnailConfig.network(
        src:
            "https://i.ytimg.com/vi/${VideoId.fromString(videoId).value}/maxresdefault.jpg",
        aspectRatio: 16 / 9,
      );

  late final RawVideoPlayerController rawController;

  @override
  Duration get duration => rawController.duration;

  @override
  void hideControls() => rawController.hideControls();

  @override
  void initialised() {
    value = value.copyWith(isInitialised: true);
  }

  @override
  Duration get position => rawController.position;

  @override
  void showControls() => rawController.showControls();

  @override
  VideoPlayerController get videoPlayerController =>
      rawController.videoPlayerController;

  Future<void> _createController() async {
    final yt = YoutubeExplode();
    final id = VideoId.fromString(videoId);
    final streamInfo = await yt.videos.streamsClient.getManifest(id);
    final streamable = streamInfo.muxed.first.url;
    rawController = RawVideoPlayerController(
      videoPlayerController: VideoPlayerController.networkUrl(streamable),
      autoPlay: true,
      thumbnail: thumbnail,
    );
    yt.close();
  }

  @override
  // ignore: must_call_super
  Future<void> init() async {
    await _createController();
    initialised();
  }
}
