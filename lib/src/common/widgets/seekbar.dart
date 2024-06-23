import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_player_extended/src/common/video_player_controller_base.dart';

class Seekbar extends StatefulWidget {
  const Seekbar({
    required this.controller,
    super.key,
  });

  final VideoPlayerControllerBase controller;

  @override
  State<Seekbar> createState() => _SeekbarState();
}

class _SeekbarState extends State<Seekbar> {
  void _listen() {
    setState(() {});
  }

  @override
  void initState() {
    widget.controller
      ..removeListener(_listen)
      ..addListener(_listen);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SeekBar(
      duration: widget.controller.duration,
      position: widget.controller.position,
      buffered: widget.controller.buffered,
      color: Colors.red,
      onChanged: (position) {
        widget.controller.seekTo(position);
      },
      onChangeEnd: (position) {
        widget.controller.seekTo(position);
      },
    );
  }
}

class _SeekBar extends StatefulWidget {
  const _SeekBar({
    required this.duration,
    required this.position,
    this.buffered = Duration.zero,
    this.color,
    this.onChanged,
    this.onChangeEnd,
  });

  final Duration duration;
  final Duration buffered;
  final Duration position;
  final Color? color;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<_SeekBar> {
  double? _dragValue;
  bool _dragging = false;

  @override
  Widget build(BuildContext context) {
    final value = min(
      _dragValue ?? widget.position.inMilliseconds.toDouble(),
      widget.duration.inMilliseconds.toDouble(),
    );
    final max = widget.duration.inMilliseconds.toDouble();
    final bufferedValue = min(
      widget.buffered.inMilliseconds.toDouble(),
      max,
    );

    if (_dragValue != null && !_dragging) {
      _dragValue = null;
    }
    return Slider(
      allowedInteraction: SliderInteraction.tapAndSlide,
      activeColor: widget.color,
      inactiveColor: Colors.white24,
      max: widget.duration.inMilliseconds.toDouble(),
      value: value,
      secondaryTrackValue: bufferedValue,
      secondaryActiveColor: Colors.white54,
      onChangeStart: (value) {
        _dragging = true;
      },
      onChanged: (value) {
        setState(() => _dragValue = value);
        widget.onChanged?.call(Duration(milliseconds: value.round()));
      },
      onChangeEnd: (value) {
        widget.onChangeEnd?.call(Duration(milliseconds: value.round()));
        _dragging = false;
      },
    );
  }
}
