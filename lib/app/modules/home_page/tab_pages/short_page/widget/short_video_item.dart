import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/short_article.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/short_page/widget/short_item_controller.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/theme/custom_text_style.dart';
import 'package:mirrordaily_app/core/values/image_path.dart';
import 'package:mirrordaily_app/core/values/string.dart';
import 'package:video_player/video_player.dart';

class ShortVideoItem extends StatefulWidget {
  const ShortVideoItem(
      {super.key,
      required this.article,
      required this.videoPlayerControllerInitCallBack});

  final ShortArticle article;
  final Function(VideoPlayerController?) videoPlayerControllerInitCallBack;

  @override
  State<ShortVideoItem> createState() => _ShortVideoItemState();
}

class _ShortVideoItemState extends State<ShortVideoItem> {
  ShortItemController? controller;

  @override
  void initState() {
    _initController();
  }

  Future<void> _initController() async {
    if (!Get.isRegistered<ShortItemController>(tag: widget.article.name)) {
      Get.put(ShortItemController(widget.article), tag: widget.article.name);
    }
    controller = Get.find<ShortItemController>(tag: widget.article.name);
    widget.videoPlayerControllerInitCallBack(
      controller?.rxnVideoPlayerController.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final videoPlayerController = controller?.rxnVideoPlayerController.value;
      return videoPlayerController != null
          ? InkWell(
              onTap: () {
                if (videoPlayerController.value.isPlaying == true) {
                  videoPlayerController.pause();
                } else {
                  videoPlayerController.play();
                }
              },
              child: AspectRatio(
                aspectRatio: videoPlayerController.value.aspectRatio,
                child: VideoPlayer(videoPlayerController),
              ),
            )
          : const Center(child: CircularProgressIndicator());
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller?.onClose();
    Get.delete<ShortItemController>(tag: widget.article.name);
    widget.videoPlayerControllerInitCallBack(null);
  }
}
