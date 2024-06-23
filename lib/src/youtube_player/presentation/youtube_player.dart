import 'package:flutter/material.dart';
import 'package:video_player_extended/video_player_extended.dart';

class YoutubePlayer extends StatefulWidget {
  const YoutubePlayer(
    this.controller, {
    super.key,
    this.aspectRatio = 16 / 9,
    this.onReady,
  });

  /// The controller for the video you want to play
  final YoutubePlayerController controller;
  final double aspectRatio;
  final VoidCallback? onReady;

  @override
  State<YoutubePlayer> createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<YoutubePlayer> {
  YoutubePlayerController get controller => widget.controller;

  void listener() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
    controller.initialise();
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.aspectRatio,
      child: FutureBuilder(
        future: controller.initialiseFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                VideoPlayerBase(controller: controller),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
