import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_extended/src/common/controls_config.dart';
import 'package:video_player_extended/src/common/index.dart';
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
  VideoPlayer get player => widget.player;

  @override
  Widget build(BuildContext context) {
    final config = context.selectControllerValues<T, ControlsConfig>(
      (T controller) => controller.value.controlsConfig,
    );
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        player,
        Positioned.fill(child: Container(color: Colors.black45)),
        Positioned(
          bottom: 0,
          left: 16,
          right: 16,
          child: Row(
            children: [
              Expanded(child: Seekbar<T>(config: config)),
            ],
          ),
        ),
      ],
    );
  }
}
