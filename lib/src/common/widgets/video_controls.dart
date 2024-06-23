import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player_extended/src/common/video_player_controller_base.dart';
import 'package:video_player_extended/src/common/widgets/seekbar.dart';
import 'package:video_player_extended/video_player_extended.dart';

@immutable
class VideoControlOptions {
  const VideoControlOptions({
    this.allowScrubbing = true,
    this.showProgressIndicator = true,
    this.showCaption = true,
    this.autoHideDuration = const Duration(seconds: 3),
  });

  final bool allowScrubbing;
  final bool showProgressIndicator;
  final bool showCaption;
  final Duration autoHideDuration;

  VideoControlOptions copyWith({
    bool? allowScrubbing,
    bool? showProgressIndicator,
    bool? showCaption,
    Duration? autoHideDuration,
  }) {
    return VideoControlOptions(
      allowScrubbing: allowScrubbing ?? this.allowScrubbing,
      showProgressIndicator:
          showProgressIndicator ?? this.showProgressIndicator,
      showCaption: showCaption ?? this.showCaption,
      autoHideDuration: autoHideDuration ?? this.autoHideDuration,
    );
  }

  @override
  String toString() {
    return '(allowScrubbing: $allowScrubbing, showProgressIndicator: $showProgressIndicator, showCaption: $showCaption, autoHideDuration: $autoHideDuration)';
  }

  @override
  int get hashCode => Object.hashAll([
        allowScrubbing,
        showProgressIndicator,
        showCaption,
        autoHideDuration,
      ]);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VideoControlOptions &&
        other.allowScrubbing == allowScrubbing &&
        other.showProgressIndicator == showProgressIndicator &&
        other.showCaption == showCaption &&
        other.autoHideDuration == autoHideDuration;
  }
}

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
          ClosedCaption(text: videoPlayerController.value.caption.text),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            children: [
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
          GestureDetector(onTap: _handleTap),
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
          AnimatedSwitcher(
            duration: Durations.medium2,
            child: visible ? controls : null,
          ),
        ],
      ),
    );
  }
}
