import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player_extended/src/common/models/video_control_options.dart';
import 'package:video_player_extended/src/common/video_player_controller_base.dart';
import 'package:video_player_extended/src/common/widgets/seekbar.dart';
import 'package:video_player_extended/src/common/widgets/speed_control.dart';
import 'package:video_player_extended/video_player_extended.dart';

class VideoControls extends StatefulWidget {
  const VideoControls(
    this.controller, {
    super.key,
    VideoControlOptions? options,
  }) : options = options ?? const VideoControlOptions();

  final VideoPlayerControllerBase controller;
  final VideoControlOptions options;

  @override
  State<VideoControls> createState() => _VideoControlsState();
}

class _VideoControlsState extends State<VideoControls> {
  bool visible = false;
  Timer? timer;

  void _handleTap() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }

    setState(() {
      visible = !visible;
    });

    if (visible) {
      _startAutoHideTimer();
    }
  }

  void _startAutoHideTimer() {
    timer = Timer(widget.options.autoHideDuration, () {
      setState(() {
        visible = false;
      });
    });
  }

  VideoPlayerController get videoPlayerController =>
      widget.controller.videoPlayerController;

  @override
  Widget build(BuildContext context) {
    final controls = Stack(
      alignment: Alignment.bottomCenter,
      children: [
        IgnorePointer(child: Container(color: Colors.black.withOpacity(0.5))),
        if (widget.options.showCaption)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              children: [
                SpeedControl(widget.controller),
                Expanded(child: Seekbar(controller: widget.controller)),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.fullscreen_rounded),
                )
              ],
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 32,
              onPressed: () =>
                  widget.controller.skipBackward(const Duration(seconds: 5)),
              icon: const Icon(Icons.replay_5_rounded),
            ),
            PlayPauseCTA(videoPlayerController),
            IconButton(
              iconSize: 32,
              onPressed: () =>
                  widget.controller.skipForward(const Duration(seconds: 5)),
              icon: const Icon(Icons.forward_5_rounded),
            ),
          ],
        ),
      ],
    );

    return IconTheme(
      data: const IconThemeData(color: Colors.white),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GestureDetector(onTapUp: (_) => _handleTap()),
          if (widget.options.showProgressIndicator)
            AnimatedSwitcher(
              duration: Durations.short4,
              child: !visible
                  ? VideoProgressIndicator(
                      widget.controller.videoPlayerController,
                      allowScrubbing: widget.options.allowScrubbing,
                    )
                  : null,
            ),
          ClosedCaption(
            text: videoPlayerController.value.caption.text,
            textStyle: const TextStyle(color: Colors.white),
          ),
          AnimatedSwitcher(
            duration: Durations.medium2,
            child: visible ? controls : null,
          ),
        ],
      ),
    );
  }
}
