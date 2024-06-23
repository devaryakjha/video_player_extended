import 'package:video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final class YoutubeClosedCaption implements ClosedCaptionFile {
  YoutubeClosedCaption(ClosedCaptionTrack track)
      : _captions = _createCaptions(track);

  final List<Caption> _captions;

  static List<Caption> _createCaptions(ClosedCaptionTrack track) {
    return track.captions.indexed.map(
      (data) {
        final (index, caption) = data;
        return Caption(
          number: index,
          text: caption.text,
          start: caption.offset,
          end: caption.end,
        );
      },
    ).toList();
  }

  @override
  List<Caption> get captions => _captions;
}
