import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

final class ThumbnailConfig extends Equatable {
  final String? src;
  final double? width;
  final double? height;
  final double? aspectRatio;
  final ThumbnailType type;
  final Widget? custom;

  const ThumbnailConfig._({
    this.src,
    this.width,
    this.height,
    this.aspectRatio,
    required this.type,
    this.custom,
  })  : assert(
          type != ThumbnailType.custom || custom != null,
          'Custom thumbnail must not be null',
        ),
        assert(
          type != ThumbnailType.custom || src == null,
          'Custom thumbnail must not have src',
        ),
        assert(
          type != ThumbnailType.custom
              ? ((width != null && height != null) || aspectRatio != null)
              : true,
          'Either width and height or aspect ratio must be provided',
        );

  const ThumbnailConfig.network({
    required String src,
    double? width,
    double? height,
    double? aspectRatio,
  }) : this._(
          src: src,
          width: width,
          height: height,
          aspectRatio: aspectRatio,
          type: ThumbnailType.network,
        );

  const ThumbnailConfig.file({
    required String src,
    double? width,
    double? height,
    double? aspectRatio,
  }) : this._(
          src: src,
          width: width,
          height: height,
          aspectRatio: aspectRatio,
          type: ThumbnailType.file,
        );

  const ThumbnailConfig.asset({
    required String src,
    double? width,
    double? height,
    double? aspectRatio,
  }) : this._(
          src: src,
          width: width,
          height: height,
          aspectRatio: aspectRatio,
          type: ThumbnailType.asset,
        );

  const ThumbnailConfig.custom({
    required Widget custom,
    double? width,
    double? height,
    double? aspectRatio,
  }) : this._(
          width: width,
          height: height,
          aspectRatio: aspectRatio,
          type: ThumbnailType.custom,
          custom: custom,
        );

  @override
  List<Object?> get props => [src, width, height, aspectRatio, custom];
}

enum ThumbnailType {
  network,
  file,
  asset,
  custom;
}
