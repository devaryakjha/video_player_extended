library video_player_extended;

export 'package:video_player/video_player.dart' show VideoPlayerController;

export 'src/common/index.dart'
    show
        ReadControllerExtension,
        WatchControllerExtension,
        SelectControllerExtension;
export 'src/players/raw/index.dart'
    show RawVideoPlayerController, RawVideoPlayer;
