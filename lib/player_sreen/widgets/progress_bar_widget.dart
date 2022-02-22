import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_demo/providers/player_provider.dart';
import 'package:provider/provider.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progressBarState = context.select<PlayerProvider, ProgressBarState>(
      (provider) => provider.progressBarState,
    );
    return ProgressBar(
      progress: progressBarState.positionDuration,
      total: progressBarState.totalDuration,
      buffered: progressBarState.bufferedDuration,
      onSeek: (Duration duration) => _onSeek(context, duration),
    );
  }

  _onSeek(BuildContext context, Duration duration) {
    context.read<PlayerProvider>().seek(duration);
  }
}
