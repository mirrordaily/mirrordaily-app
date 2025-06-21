import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/widgets/draft_js_widget_factory/widget/youtube_widget/youtube_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeWidget extends StatelessWidget {
  const YoutubeWidget({super.key, required this.videoUrl});

  final String videoUrl;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(YoutubeController(videoUrl));
    return Obx(() {
      final youtubePlayerController =
          controller.rxnYoutubePlayerController.value;
      return youtubePlayerController != null
          ? YoutubePlayer(
              controller: youtubePlayerController,
              showVideoProgressIndicator: true,
              onReady: () {
                print('Player is ready.');
              },
              onEnded: (metaData) {
                print('Video has ended.');
              },
            )
          : const SizedBox.shrink();
    });
  }
}
