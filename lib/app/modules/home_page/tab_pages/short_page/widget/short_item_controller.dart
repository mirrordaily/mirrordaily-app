import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/short_article.dart';
import 'package:mirrordaily_app/app/data/models/video_item.dart';
import 'package:mirrordaily_app/app/data/providers/local_cache_provider.dart';
import 'package:video_player/video_player.dart';

class ShortItemController extends GetxController {
  final ShortArticle shortArticle;
  final Rxn<VideoPlayerController> rxnVideoPlayerController = Rxn();
  final LocalCacheProvider localCacheProvider = Get.find();

  ShortItemController(this.shortArticle) {
    if (shortArticle.videoSrc != null) {
      rxnVideoPlayerController.value =
          VideoPlayerController.networkUrl(Uri.parse(shortArticle.videoSrc!))
            ..initialize().then((_) {
              rxnVideoPlayerController.value?.play();
              rxnVideoPlayerController.value?.setLooping(true);
              rxnVideoPlayerController.update((v) {});
            });
      rxnVideoPlayerController.value?.addListener(_videoListener);
    }
  }

  void _videoListener() {
    if (rxnVideoPlayerController.value == null) return;
    final currentPosition = rxnVideoPlayerController.value?.value.position;
    final totalDuration = rxnVideoPlayerController.value?.value.duration;
    if (currentPosition == null || totalDuration == null) return;
    if (currentPosition > const Duration(seconds: 1) &&
        (currentPosition >= const Duration(seconds: 15) ||
            currentPosition >= totalDuration - const Duration(seconds: 3))) {
      localCacheProvider.updateWatchedVideo(
          videoItem: VideoItem(
              id: shortArticle.id ?? "-1", lastWatched: DateTime.now()));

      rxnVideoPlayerController.value?.removeListener(_videoListener);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    rxnVideoPlayerController.value?.dispose();
    super.onClose();
  }
}
