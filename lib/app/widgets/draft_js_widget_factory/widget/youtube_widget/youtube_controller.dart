import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeController extends GetxController {
  String? videoUrl;

  final Rxn<YoutubePlayerController> rxnYoutubePlayerController = Rxn();

  YoutubeController(this.videoUrl);

  @override
  void onInit() {
    super.onInit();

    if (videoUrl == null) return;
    final videoId = YoutubePlayer.convertUrlToId(videoUrl!);
    rxnYoutubePlayerController.value = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }
}
