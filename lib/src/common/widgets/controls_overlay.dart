import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_extended/src/common/index.dart';
import 'package:video_player_extended/src/common/widgets/animated_play_pause.dart';
import 'package:video_player_extended/src/common/widgets/seekbar.dart';

class ControlsOverlay<T extends PlayerController> extends StatefulWidget {
  const ControlsOverlay({
    required this.player,
    super.key,
  });

  final VideoPlayer player;

  @override
  State<ControlsOverlay<T>> createState() => _ControlsOverlayState<T>();
}

class _ControlsOverlayState<T extends PlayerController>
    extends State<ControlsOverlay<T>> {
  Timer? _hideTimer;
  VideoPlayer get player => widget.player;
  bool _displayTapped = false;

  void _cancelAndRestartTimer() {
    _hideTimer?.cancel();
    _startHideTimer();
    _displayTapped = true;
    context.readController<T>().showControls();
  }

  void _startHideTimer() {
    final control = context.readController<T>();
    _hideTimer = Timer(const Duration(seconds: 3), control.hideControls);
  }

  void _playPause() {
    final control = context.readController<T>();
    final isFinished = control.isFinished;

    if (control.isPlaying) {
      control.showControls();
      _hideTimer?.cancel();
      control.pause();
    } else {
      _cancelAndRestartTimer();

      if (!control.value.isInitialised) {
        control.init().then((_) {
          control.play();
        });
      } else {
        if (isFinished) {
          control.seekTo(Duration.zero);
        }
        control.play();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watchController();
    final (config, controlsHidden, isPlaying, isFinished) = (
      controller.value.controlsConfig,
      controller.controlsHidden,
      controller.isPlaying,
      controller.isFinished,
    );

    final controls = Stack(
      key: const ValueKey('controls'),
      children: [
        Positioned.fill(child: Container(color: Colors.black45)),
        Positioned(
          bottom: 0,
          left: 16,
          right: 16,
          child: Row(
            children: [
              Expanded(
                child: Seekbar<T>(
                  config: config,
                  onValueUpdate: _cancelAndRestartTimer,
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Center(
            child: GestureDetector(
              onTap: () {
                if (isPlaying) {
                  if (_displayTapped) {
                    context.readController<T>().hideControls();
                  } else {
                    _cancelAndRestartTimer();
                  }
                } else {
                  _playPause();

                  context.readController<T>().hideControls();
                }
              },
              child: IconButton(
                onPressed: _playPause,
                color: Colors.white,
                iconSize: 56,
                icon: isFinished
                    ? const Icon(Icons.replay)
                    : AnimatedPlayPause(playing: isPlaying),
              ),
            ),
          ),
        )
      ],
    );
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        player,
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: _cancelAndRestartTimer,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: controlsHidden ? null : controls,
          ),
        )
      ],
    );
  }
}
