import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  VideoPlayerController? videoPlayerController;
  final Rxn<ChewieController> chewieController=Rxn();
  String? videoUrl;

  VideoController(this.videoUrl);

  @override
  void onInit() async {
    super.onInit();
    if (videoUrl == null) return;
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl!));
    await videoPlayerController?.initialize();
    chewieController.value = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: false,
      looping: false,
      aspectRatio: videoPlayerController?.value.aspectRatio,
    );
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    chewieController.value?.dispose();
  }
}
