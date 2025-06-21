import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/enums/topic_leading_type.dart';
import 'package:mirrordaily_app/app/data/models/topic.dart';
import 'package:video_player/video_player.dart';

class TopicLeadingController extends GetxController {
  final Rxn<Topic> rxnTopic = Rxn();
  final RxInt rxSlideshowIndex = 0.obs;
  late PageController pageController;
  final Rxn<VideoPlayerController> rxnVideoPlayerController = Rxn();
  Timer? _slideshowTimer;


  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    rxnVideoPlayerController.value?.pause();
    _slideshowTimer?.cancel();
    pageController.dispose();
    super.onClose();
  }

  void setTopic(Topic? topic) {
    rxnTopic.value = topic;
    if (rxnTopic.value?.leading == TopicLeadingType.slideShow) {
      startAutoPlay();
    } else if (rxnTopic.value?.leading == TopicLeadingType.video) {
      if (rxnTopic.value?.videoUrl != null) {
        rxnVideoPlayerController.value = VideoPlayerController.networkUrl(
            Uri.parse(rxnTopic.value!.videoUrl!));
        rxnVideoPlayerController.value?.initialize().then((_) {
          rxnVideoPlayerController.refresh();
          rxnVideoPlayerController.value?.play();
        });
      }
    }
  }

  void slideshowIndexChangeEvent(int index) {
    rxSlideshowIndex.value = index;
  }

  void startAutoPlay({int duration = 3}) {
    _slideshowTimer?.cancel(); // 先取消舊的 Timer，防止重複啟動
    _slideshowTimer = Timer.periodic(Duration(seconds: duration), (timer) {
      int nextIndex = rxSlideshowIndex.value + 1;
      if (nextIndex == (rxnTopic.value!.slideshowImageList.length))
        nextIndex = 0;

      pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      rxSlideshowIndex.value = nextIndex;
    });
  }

  void stopAutoPlay() {
    _slideshowTimer?.cancel();
  }

  void videoOnClickEvent() {
    if (rxnVideoPlayerController.value == null) {
      return;
    }
    if (rxnVideoPlayerController.value!.value.isPlaying) {
      rxnVideoPlayerController.value?.pause();
    } else {
      rxnVideoPlayerController.value?.play();
    }
  }


}
