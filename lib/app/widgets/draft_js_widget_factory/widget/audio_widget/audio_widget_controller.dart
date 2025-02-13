import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
class AudioWidgetController extends GetxController {
  String? audioPath;

  AudioWidgetController(this.audioPath);

  AudioPlayer audioPlayer = AudioPlayer();

  final Rx<PlayerState> rxAudioPlayerState =
      Rx<PlayerState>(PlayerState.stopped);
  final Rxn<Duration> rxnAudioDuration = Rxn();
  final Rxn<Duration> rxnAudioPosition = Rxn();

  PlayerState audioPlayStateBuffer = PlayerState.stopped;

  @override
  void onInit() {
    super.onInit();
    if (audioPath != null) {
      audioPlayer = AudioPlayer();

      audioPlayer.setSourceUrl(audioPath!);
    }

    audioPlayer.onPlayerStateChanged.listen((state) {
      rxAudioPlayerState.value = state;
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      rxnAudioDuration.value = newDuration;
    });


    audioPlayer.onPositionChanged.listen((newPosition) {
      rxnAudioPosition.value = newPosition;
    });
  }

  void onPlayPauseButtonClick() {
    if (audioPlayer.state == PlayerState.playing) {
      audioPlayer.pause();
    }
    if (audioPlayer.state == PlayerState.paused ||
        audioPlayer.state == PlayerState.stopped) {
      audioPlayer.resume();
    }
  }

  void slideBarValueChangeStart(value) async {
    audioPlayStateBuffer = audioPlayer.state;
  }

  void slideBarValueChange(double value) async {
    final newPosition = Duration(seconds: value.toInt());
    await audioPlayer.seek(newPosition);
    if (audioPlayer.state == PlayerState.playing) {
      audioPlayer.pause();
    }
  }

  void slideBarValueChangeEnd(value) async {
    if (audioPlayStateBuffer == PlayerState.playing) {
      await audioPlayer.resume();
    } else {
      await audioPlayer.pause();
    }
  }
}
