import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/enums/short_preview_source.dart';
import 'package:mirrordaily_app/app/modules/post_short_video_page/post_short_controller.dart';
import 'package:mirrordaily_app/app/widgets/custom_elevated_button.dart';
import 'package:mirrordaily_app/app/widgets/custom_outlined_button.dart';
import 'package:mirrordaily_app/app/widgets/custom_text_field.dart';
import 'package:mirrordaily_app/app/widgets/custom_text_form_field.dart';

import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/theme/custom_text_style.dart';
import 'package:video_player/video_player.dart';

class PostShortVideoPage extends GetView<PostShortVideoController> {
  const PostShortVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('短影音投稿'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Flex(
                  direction: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '影片標題',
                                style: CustomTextStyle.subtitleSmall?.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                '(必填)',
                                style: Get.textTheme.bodySmall?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: CustomColorTheme.secondary50),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 28,
                            child: CustomTextField(
                                controller:
                                    controller.titleTextEditingController),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            '影片說明',
                            style: CustomTextStyle.subtitleMedium.copyWith(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                              height: 198,
                              child: CustomTextField(
                                  maxLines: 100,
                                  controller: controller
                                      .videoExplanationTextEditingController)),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Text(
                                '影片首圖',
                                style: CustomTextStyle.subtitleSmall?.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                '(必填)',
                                style: Get.textTheme.bodySmall?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: CustomColorTheme.secondary50),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: controller.autoPreviewImageClick,
                                      child: Obx(() {
                                        final thumbnailPath = controller
                                            .rxnAutoThumbnailPath.value;
                                        final previewSource = controller
                                            .rxShortPreviewSource.value;
                                        return thumbnailPath != null
                                            ? Container(
                                                height: 120,
                                                width: 70,
                                                decoration: previewSource ==
                                                        ShortPreviewSource.auto
                                                    ? BoxDecoration(
                                                        border: Border.all(
                                                          color:
                                                              CustomColorTheme
                                                                  .primary40,
                                                          // 邊框顏色
                                                          width: 3.0, // 邊框寬度
                                                        ),
                                                        // 圓角
                                                      )
                                                    : null,
                                                child: Image.file(
                                                  File(thumbnailPath),
                                                  height: 120,
                                                  width: 70,
                                                ),
                                              )
                                            : Container(
                                                height: 120,
                                                color: Colors.grey,
                                              );
                                      }),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '自動',
                                      style: CustomTextStyle.subtitleSmall
                                          ?.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 11,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: controller.selectCustomThumbnail,
                                      child: Obx(() {
                                        final thumbnailPath = controller
                                            .rxnCustomThumbnailPath.value;
                                        final previewSource = controller
                                            .rxShortPreviewSource.value;
                                        return thumbnailPath != null
                                            ? Container(
                                                height: 120,
                                                width: 70,
                                                decoration: previewSource ==
                                                        ShortPreviewSource
                                                            .customer
                                                    ? BoxDecoration(
                                                        border: Border.all(
                                                          color:
                                                              CustomColorTheme
                                                                  .primary40,
                                                          // 邊框顏色
                                                          width: 3.0, // 邊框寬度
                                                        ),
                                                        // 圓角
                                                      )
                                                    : null,
                                                child: Image.file(
                                                  File(thumbnailPath),
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : Container(
                                                height: 120,
                                                width: 70,
                                                color: Colors.grey,
                                              );
                                      }),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '上傳圖片',
                                      style: CustomTextStyle.subtitleSmall
                                          ?.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 8),
                                    Obx(() {
                                      final isCanReUpload = controller
                                          .rxnCustomThumbnailPath.value;
                                      return isCanReUpload != null
                                          ? InkWell(
                                              onTap: controller
                                                  .reUploadButtonClick,
                                              child: Container(
                                                  height: 16,
                                                  width: double.infinity,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: CustomColorTheme
                                                        .secondary40,
                                                    // 背景顏色: #666C81
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4), // 邊角圓弧: 4px
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                    '重新上傳',
                                                    style: Get
                                                        .textTheme.labelMedium
                                                        ?.copyWith(
                                                            color:
                                                                CustomColorTheme
                                                                    .secondary99),
                                                    textAlign: TextAlign.center,
                                                  ))),
                                            )
                                          : const SizedBox.shrink();
                                    })
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 35,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '影片預覽',
                                style: CustomTextStyle.subtitleSmall.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 270,
                            child: Obx(() {
                              final videoPlayerController =
                                  controller.rxnVideoPlayerController.value;
                              return videoPlayerController != null &&
                                      videoPlayerController.value.isInitialized
                                  ? AspectRatio(
                                      aspectRatio: videoPlayerController
                                          .value.aspectRatio,
                                      child: VideoPlayer(videoPlayerController),
                                    )
                                  : const SizedBox.shrink();
                            }),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 153,
                      child: CustomElevatedButton(
                        isActive: true,
                        text: "下一步",
                        onClickEvent: controller.nextStepButtonClick,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 44,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
