import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerProvider extends ChangeNotifier {
  late AudioPlayer _audioPlayer;

  late ProgressBarState _progressBarState;
  late PlayerButtonState _playerButtonState;

  ProgressBarState get progressBarState => _progressBarState;
  PlayerButtonState get playerButtonState => _playerButtonState;

  PlayerProvider() {
    _initAudioPlayer();
    _initInitialStates();
    _initPlayerStateChanges();
    _initProgressStateChanges();
  }

  _initInitialStates() {
    // initially player is stopped and progress bar's values are zero.
    _playerButtonState = PlayerButtonState.paused;
    _progressBarState = const ProgressBarState(
      positionDuration: Duration.zero,
      totalDuration: Duration.zero,
      bufferedDuration: Duration.zero,
    );
    notifyListeners();
  }

  _initAudioPlayer() async {
    _audioPlayer = AudioPlayer();
    await _audioPlayer.setUrl('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-9.mp3');
  }

  _initPlayerStateChanges() {
    _audioPlayer.playerStateStream.listen((state) {
      final _playing = state.playing;
      final _processingState = state.processingState;

      switch (_processingState) {
        case ProcessingState.idle:
          playerButtonState = PlayerButtonState.paused;
          break;
        case ProcessingState.buffering:
          playerButtonState = PlayerButtonState.loading;
          break;
        case ProcessingState.loading:
          playerButtonState = PlayerButtonState.loading;
          break;
        case ProcessingState.completed:
          seek(Duration.zero);
          pause();
          break;
        case ProcessingState.ready:
          playerButtonState = _playing ? PlayerButtonState.playing : PlayerButtonState.paused;
          break;
      }
    });
  }

  _initProgressStateChanges() {
    // This stream is used to update the progress bar's total duration value.
    _audioPlayer.durationStream.listen((duration) {
      final oldState = progressBarState;
      progressBarState = ProgressBarState(
        positionDuration: oldState.positionDuration,
        totalDuration: duration ?? Duration.zero,
        bufferedDuration: oldState.bufferedDuration,
      );
    });

    // This stream is used to update the progress bar's buffered values.
    _audioPlayer.bufferedPositionStream.listen((duration) {
      final oldState = progressBarState;
      progressBarState = ProgressBarState(
        positionDuration: oldState.positionDuration,
        totalDuration: oldState.totalDuration,
        bufferedDuration: duration,
      );
    });

    // This stream is used to update the progress bar's position values.
    _audioPlayer.positionStream.listen((duration) {
      final oldState = progressBarState;
      progressBarState = ProgressBarState(
        positionDuration: duration,
        totalDuration: oldState.totalDuration,
        bufferedDuration: oldState.bufferedDuration,
      );
    });
  }

  set playerButtonState(PlayerButtonState state) {
    _playerButtonState = state;
    notifyListeners();
  }

  set progressBarState(ProgressBarState state) {
    _progressBarState = state;
    notifyListeners();
  }

  Future<void> setAudioUrl(String url) async {}

  void play() async {
    await _audioPlayer.play();
  }

  void pause() async {
    await _audioPlayer.pause();
  }

  void stop() async {
    await _audioPlayer.stop();
  }

  void seek(Duration duration) async {
    await _audioPlayer.seek(duration);
  }

  void disposeAudioPlayer() async {
    await _audioPlayer.dispose();
  }
}

class ProgressBarState {
  final Duration positionDuration;
  final Duration totalDuration;
  final Duration bufferedDuration;

  const ProgressBarState({
    required this.positionDuration,
    required this.totalDuration,
    required this.bufferedDuration,
  });
}

enum PlayerButtonState {
  playing,
  paused,
  loading,
}
