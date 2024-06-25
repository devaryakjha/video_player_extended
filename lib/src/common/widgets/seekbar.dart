import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_player_extended/src/common/controls_config.dart';
import 'package:video_player_extended/src/common/index.dart';

class Seekbar<T extends PlayerController> extends StatefulWidget {
  const Seekbar({
    super.key,
    required this.config,
  });

  final ControlsConfig config;

  @override
  State<Seekbar> createState() => _SeekbarState();
}

class _SeekbarState<T extends PlayerController> extends State<Seekbar<T>> {
  double? _dragValue;
  bool _dragging = false;

  ControlsConfig get config => widget.config;

  Text _buildTextProgress(Duration value) {
    // format into hours and minutes not seconds
    String formatted;
    if (value.inHours > 0) {
      formatted =
          '${value.inHours}:${(value.inMinutes % 60).toString().padLeft(2, '0')}:${(value.inSeconds % 60).toString().padLeft(2, '0')}';
      return Text(formatted, style: config.progressBarTextStyle);
    } else {
      formatted =
          '${value.inMinutes}:${(value.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return Text(formatted, style: config.effectiveProgressBarTextStyle);
  }

  @override
  Widget build(BuildContext context) {
    final (duration, position, buffered, seekTo) =
        context.selectControllerValues(
      (T controller) {
        return (
          controller.duration,
          controller.position,
          controller.buffered,
          controller.videoPlayerController.seekTo,
        );
      },
    );

    final value = min(
      _dragValue ?? position.inMilliseconds.toDouble(),
      duration.inMilliseconds.toDouble(),
    );
    final max = duration.inMilliseconds.toDouble();

    final bufferedValue = min(
      buffered.inMilliseconds.toDouble(),
      duration.inMilliseconds.toDouble(),
    );

    if (_dragValue != null && !_dragging) {
      _dragValue = null;
    }

    return SliderTheme(
      data: config.effectiveSlideTheme,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTextProgress(position),
          Expanded(
            child: Slider(
              max: max,
              value: value,
              secondaryTrackValue: bufferedValue,
              onChangeStart: (value) {
                _dragging = true;
              },
              onChanged: (value) {
                setState(() => _dragValue = value);
              },
              onChangeEnd: (value) {
                final newValue = Duration(milliseconds: value.round());
                seekTo(newValue);
                _dragging = false;
              },
            ),
          ),
          _buildTextProgress(duration),
        ],
      ),
    );
  }
}
