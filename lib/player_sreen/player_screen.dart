import 'package:flutter/material.dart';

import 'widgets/play_pause_button_widget.dart';
import 'widgets/progress_bar_widget.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Audio Player Demo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            ProgressBarWidget(),
            PlayPauseButtonWidget(),
          ],
        ),
      ),
    );
  }
}
