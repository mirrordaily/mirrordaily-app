import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/short_article.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/short_page/widget/short_item_controller.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/theme/custom_text_style.dart';
import 'package:mirrordaily_app/core/values/string.dart';
import 'package:video_player/video_player.dart';

class ShortVideoItem extends StatefulWidget {
  const ShortVideoItem(
      {super.key,
      required this.article,
      this.videoPlayerControllerInitCallBack});

  final ShortArticle article;
  final Function(VideoPlayerController?)? videoPlayerControllerInitCallBack;

  @override
  State<ShortVideoItem> createState() => _ShortVideoItemState();
}

class _ShortVideoItemState extends State<ShortVideoItem> {
  ShortItemController? controller;

  @override
  void initState() {
    if (!Get.isRegistered<ShortItemController>(tag: widget.article.name)) {
      Get.put(ShortItemController(widget.article), tag: widget.article.name);
    }
    controller = Get.find<ShortItemController>(tag: widget.article.name);

    if (widget.videoPlayerControllerInitCallBack != null) {
      widget.videoPlayerControllerInitCallBack!(
          controller?.rxnVideoPlayerController.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Obx(() {
          final videoPlayerController =
              controller?.rxnVideoPlayerController.value;
          return videoPlayerController != null
              ? InkWell(
                  onTap: () {
                    if (videoPlayerController.value.isPlaying == true) {
                      videoPlayerController.pause();
                    } else {
                      videoPlayerController.play();
                    }
                  },
                  child: SizedBox(
                    width: Get.width,
                    child: AspectRatio(
                      aspectRatio: videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(videoPlayerController),
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        }),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 24,
                ),
                Text(
                  '投稿人 ${widget.article.uploader ?? StringDefault.nullString}',
                  textAlign: TextAlign.left,
                  style: CustomTextStyle.subtitleSmall.copyWith(
                      color: CustomColorTheme.primary100,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 24,
                ),
                SizedBox(
                  width: Get.width * 0.64,
                  child: Text(
                    widget.article.name ?? StringDefault.nullString,
                    textAlign: TextAlign.left,
                    style: CustomTextStyle.subtitleSmall.copyWith(
                        color: CustomColorTheme.primary100,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 44,
            )
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<ShortItemController>(tag: widget.article.name);
    if (widget.videoPlayerControllerInitCallBack != null) {
      widget.videoPlayerControllerInitCallBack!(null);
    }
  }
}
