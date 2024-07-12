import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class AudioWidgetController extends GetxController {
  String? audioPath;

  AudioWidgetController(this.audioPath);

  AudioPlayer audioPlayer = AudioPlayer();

  final Rx<PlayerState> rxAudioPlayerState =
      Rx<PlayerState>(PlayerState.STOPPED);
  final Rxn<Duration> rxnAudioDuration = Rxn();
  final Rxn<Duration> rxnAudioPosition = Rxn();

  PlayerState audioPlayStateBuffer = PlayerState.STOPPED;

  @override
  void onInit() {
    super.onInit();
    if (audioPath != null) {
      audioPlayer = AudioPlayer();
      audioPlayer.setUrl(audioPath!);
    }

    audioPlayer.onPlayerStateChanged.listen((state) {
      rxAudioPlayerState.value = state;
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      rxnAudioDuration.value = newDuration;
    });

    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      rxnAudioPosition.value = newPosition;
    });
  }

  void onPlayPauseButtonClick() {
    if (audioPlayer.state == PlayerState.PLAYING) {
      audioPlayer.pause();
    }
    if (audioPlayer.state == PlayerState.PAUSED ||
        audioPlayer.state == PlayerState.STOPPED) {
      audioPlayer.resume();
    }
  }

  void slideBarValueChangeStart(value) async {
    audioPlayStateBuffer = audioPlayer.state;
  }

  void slideBarValueChange(double value) async {
    final newPosition = Duration(seconds: value.toInt());
    await audioPlayer.seek(newPosition);
    if (audioPlayer.state == PlayerState.PLAYING) {
      audioPlayer.pause();
    }
  }

  void slideBarValueChangeEnd(value) async {
    if (audioPlayStateBuffer == PlayerState.PLAYING) {
      await audioPlayer.resume();
    } else {
      await audioPlayer.pause();
    }
  }
}
