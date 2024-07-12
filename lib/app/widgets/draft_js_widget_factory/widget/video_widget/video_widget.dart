import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/widgets/draft_js_widget_factory/widget/video_widget/video_controller.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({super.key, required this.videoUrl});

  final String videoUrl;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VideoController(videoUrl));

    return Obx(() {
      final chewieController = controller.chewieController.value;
      return chewieController != null &&
              chewieController.videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio:
                  chewieController.videoPlayerController.value.aspectRatio,
              child: Chewie(
                controller: chewieController,
              ),
            )
          : const SizedBox.shrink();
    });
  }
}
