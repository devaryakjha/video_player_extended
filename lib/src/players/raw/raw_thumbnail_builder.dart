import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player_extended/src/common/index.dart';

class RawThumbnailBuilder extends StatelessWidget {
  const RawThumbnailBuilder({
    super.key,
    required this.config,
  });

  final ThumbnailConfig? config;

  @override
  Widget build(BuildContext context) {
    if (config == null) {
      return const SizedBox.shrink();
    }

    final child = switch (config!.type) {
      ThumbnailType.asset => Image.asset(
          config!.src!,
          width: config!.width,
          height: config!.height,
          fit: BoxFit.cover,
        ),
      ThumbnailType.network => Image.network(
          config!.src!,
          width: config!.width,
          height: config!.height,
          fit: BoxFit.cover,
        ),
      ThumbnailType.file => Image.file(
          File(config!.src!),
          width: config!.width,
          height: config!.height,
          fit: BoxFit.cover,
        ),
      ThumbnailType.custom => config!.custom!,
    };

    return config!.aspectRatio != null
        ? AspectRatio(
            key: ValueKey(config!.src),
            aspectRatio: config!.aspectRatio!,
            child: child,
          )
        : KeyedSubtree(key: ValueKey(config!.src), child: child);
  }
}
