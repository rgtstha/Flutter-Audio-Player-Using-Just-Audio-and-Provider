import 'package:flutter/material.dart';
import 'package:just_audio_demo/providers/player_provider.dart';
import 'package:provider/provider.dart';

class PlayPauseButtonWidget extends StatelessWidget {
  const PlayPauseButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonState = context.select<PlayerProvider, PlayerButtonState>(
      (provider) => provider.playerButtonState,
    );

    switch (buttonState) {
      case PlayerButtonState.paused:
        return IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: () => _onPlayPressed(context),
        );
      case PlayerButtonState.playing:
        return IconButton(
          icon: const Icon(Icons.pause),
          onPressed: () => _onPausePressed(context),
        );

      case PlayerButtonState.loading:
        return SizedBox(
          height: 40,
          child: Transform.scale(
            scale: 0.5,
            child: const CircularProgressIndicator(),
          ),
        );
    }
  }

  _onPausePressed(BuildContext context) {
    context.read<PlayerProvider>().pause();
  }

  _onPlayPressed(BuildContext context) {
    context.read<PlayerProvider>().play();
  }
}
