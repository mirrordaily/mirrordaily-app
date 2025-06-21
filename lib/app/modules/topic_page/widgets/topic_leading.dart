import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/enums/topic_leading_type.dart';
import 'package:mirrordaily_app/app/data/models/topic.dart';
import 'package:mirrordaily_app/app/modules/topic_page/widgets/topic_leading_controller.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/values/string.dart';
import 'package:mirrordaily_app/routes/custom_router_observer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';

class TopicLeading extends StatefulWidget {
  const TopicLeading({super.key, required this.topic});

  final Topic topic;

  @override
  State<TopicLeading> createState() => _TopicLeadingState();
}

class _TopicLeadingState extends State<TopicLeading> with RouteAware {
  late TopicLeadingController controller;

  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<TopicLeadingController>()) {
      controller = Get.put(TopicLeadingController());
    } else {
      controller = Get.find<TopicLeadingController>();
    }
    controller.setTopic(widget.topic);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    CustomRouterObserver.routeObserver
        .subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void dispose() {
    CustomRouterObserver.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPushNext() {
    // 當有頁面蓋上來時，自動暫停影片
    final videoController = controller.rxnVideoPlayerController.value;
    if (videoController != null && videoController.value.isPlaying) {
      print('🛑 pushed to another page, pause video');
      videoController.pause();
    }
  }

  @override
  void didPopNext() {
    // 可以選擇要不要 resume
    print('▶️ popped back to this page');
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.topic.leading) {
      case TopicLeadingType.video:
        return Obx(() {
          final videoPlayerController =
              controller.rxnVideoPlayerController.value;
          return videoPlayerController != null
              ? InkWell(
                  onTap: controller.videoOnClickEvent,
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.black,
                        height: 250,
                      ),
                      Container(
                        height: 250,
                        alignment: Alignment.center,
                        child: AspectRatio(
                          aspectRatio: videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(videoPlayerController),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink();
        });

      case TopicLeadingType.slideShow:
        return Column(
          children: [
            SizedBox(
              height: 250,
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.slideshowIndexChangeEvent,
                itemCount: widget.topic.slideshowImageList.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.topic.slideshowImageList[index].w800 ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(StringDefault.imageDefaultUrl);
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            SmoothPageIndicator(
              controller: controller.pageController,
              count: widget.topic.slideshowImageList.length,
              effect: ExpandingDotsEffect(
                activeDotColor: CustomColorTheme.primary40,
                dotColor: Colors.grey,
                dotHeight: 8,
                dotWidth: 8,
              ),
            ),
          ],
        );

      case TopicLeadingType.image:
        return Container(
          color: Colors.black,
          width: double.infinity,
          height: 250,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              widget.topic.imageUrl ?? '',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(StringDefault.imageDefaultUrl);
              },
            ),
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
