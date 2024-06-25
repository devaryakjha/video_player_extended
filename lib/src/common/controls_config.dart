import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ControlsConfig extends Equatable {
  const ControlsConfig({
    this.progressBarTheme,
    this.progressBarHeight,
    this.progressBarTextStyle,
  });

  const ControlsConfig.defaults()
      : progressBarTheme = null,
        progressBarHeight = null,
        progressBarTextStyle = null;

  final SliderThemeData? progressBarTheme;
  final double? progressBarHeight;
  final TextStyle? progressBarTextStyle;

  SliderThemeData get effectiveSlideTheme =>
      progressBarTheme ?? kDefaultSlideTheme;

  TextStyle get effectiveProgressBarTextStyle =>
      progressBarTextStyle ?? kDefaultProgressBarTextStyle;

  static const kDefaultSlideTheme = SliderThemeData(
    activeTrackColor: Colors.red,
    thumbColor: Colors.red,
    inactiveTrackColor: Colors.black12,
    secondaryActiveTrackColor: Colors.white70,
    allowedInteraction: SliderInteraction.tapAndSlide,
    trackHeight: 8.0,
    thumbShape: RoundSliderThumbShape(
      enabledThumbRadius: 10.0,
    ),
  );

  static const kDefaultProgressBarTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
  );

  @override
  List<Object?> get props =>
      [progressBarTheme, progressBarHeight, progressBarTextStyle];
}
