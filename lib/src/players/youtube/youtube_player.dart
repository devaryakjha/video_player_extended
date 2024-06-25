import 'package:flutter/material.dart';
import 'package:video_player_extended/src/players/raw/raw_thumbnail_builder.dart';
import 'package:video_player_extended/video_player_extended.dart';

class YoutubePlayer extends StatefulWidget {
  const YoutubePlayer(this.controller, {super.key});

  final YoutubePlayerController controller;

  @override
  State<YoutubePlayer> createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<YoutubePlayer> {
  @override
  void initState() {
    super.initState();
    widget.controller.init().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: widget.controller.value.isInitialised
          ? RawVideoPlayer(
              widget.controller.rawController,
            )
          : RawThumbnailBuilder(config: widget.controller.thumbnail),
    );
  }
}
