import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayPauseCTA extends StatefulWidget {
  const PlayPauseCTA(this.controller, {super.key});
  final VideoPlayerController controller;

  @override
  State<PlayPauseCTA> createState() => _PlayPauseCTAState();
}

class _PlayPauseCTAState extends State<PlayPauseCTA>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      value: widget.controller.value.isPlaying ? 1.0 : 0.0,
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: IconButton(
            iconSize: 64.0,
            icon: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: controller,
            ),
            onPressed: () {
              if (widget.controller.value.isPlaying) {
                controller.reverse();
                widget.controller.pause();
              } else {
                controller.forward();
                widget.controller.play();
              }
            },
          ),
        ),
      ],
    );
  }
}
