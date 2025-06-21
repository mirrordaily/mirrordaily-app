import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/enums/short_preview_source.dart';
import 'package:mirrordaily_app/app/modules/post_short_video_page/post_short_controller.dart';
import 'package:mirrordaily_app/app/widgets/custom_elevated_button.dart';
import 'package:mirrordaily_app/app/widgets/custom_text_field.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/theme/custom_text_style.dart';
import 'package:video_player/video_player.dart';

class PostShortVideoPage extends StatefulWidget {
  const PostShortVideoPage({super.key});

  @override
  State<PostShortVideoPage> createState() => _PostShortVideoPageState();
}

class _PostShortVideoPageState extends State<PostShortVideoPage> {
  late PostShortVideoController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(PostShortVideoController());
  }

  @override
  void dispose() {
    _controller.dispose();
    // 清理 Controller 以防內存洩漏
    if (Get.isRegistered<PostShortVideoController>()) {
      Get.delete<PostShortVideoController>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('短影音投稿'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildMainContent(),
              Obx(() {
                final isNextButtonClickOn =
                    _controller.isNextButtonClickOn.value;
                return _buildNextStepButton(isNextButtonClickOn);
              }),
            ],
          ),
        ),
      ),
    );
  }

  /// 主要內容區域
  Widget _buildMainContent() {
    return Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleField(),
              const SizedBox(height: 16),
              _buildDescriptionField(),
              const SizedBox(height: 16),
              _buildThumbnailSelector(),
            ],
          ),
        ),
        const SizedBox(width: 35),
        Expanded(
          flex: 1,
          child: _buildVideoPreview(),
        ),
      ],
    );
  }

  /// 影片標題輸入框
  Widget _buildTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '影片標題',
              style: CustomTextStyle.subtitleSmall?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '(必填)',
              style: Get.textTheme.bodySmall?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: CustomColorTheme.secondary50,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 28,
          child: CustomTextField(
            maxLines: 1,
            controller: _controller.titleTextEditingController,
          ),
        ),
      ],
    );
  }

  /// 影片說明輸入框
  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '影片說明',
          style: CustomTextStyle.subtitleMedium.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 198,
          child: CustomTextField(
            maxLines: 100,
            controller: _controller.videoExplanationTextEditingController,
          ),
        ),
      ],
    );
  }

  /// 影片首圖選擇區域
  Widget _buildThumbnailSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '影片首圖',
              style: CustomTextStyle.subtitleSmall?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '(必填)',
              style: Get.textTheme.bodySmall?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: CustomColorTheme.secondary50,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAutoThumbnail(),
            const SizedBox(width: 11),
            _buildCustomThumbnail(),
          ],
        ),
      ],
    );
  }

  /// 自動首圖選擇
  Widget _buildAutoThumbnail() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: _controller.autoPreviewImageClick,
            child: Obx(() {
              final thumbnailPath = _controller.rxnAutoThumbnailPath.value;
              final previewSource = _controller.rxShortPreviewSource.value;
              return thumbnailPath != null
                  ? Container(
                      height: 120,
                      width: 70,
                      decoration: previewSource == ShortPreviewSource.auto
                          ? BoxDecoration(
                              border: Border.all(
                                color: CustomColorTheme.primary40,
                                width: 3.0,
                              ),
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
          const SizedBox(height: 4),
          Text(
            '自動',
            style: CustomTextStyle.subtitleSmall
                ?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  /// 自定義首圖上傳
  Widget _buildCustomThumbnail() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: _controller.selectCustomThumbnail,
            child: Obx(() {
              final thumbnailPath = _controller.rxnCustomThumbnailPath.value;
              final previewSource = _controller.rxShortPreviewSource.value;
              return thumbnailPath != null
                  ? Container(
                      height: 120,
                      width: 70,
                      decoration: previewSource == ShortPreviewSource.customer
                          ? BoxDecoration(
                              border: Border.all(
                                color: CustomColorTheme.primary40,
                                width: 3.0,
                              ),
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
          const SizedBox(height: 4),
          Text(
            '上傳圖片',
            style: CustomTextStyle.subtitleSmall
                ?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Obx(() {
            final isCanReUpload = _controller.rxnCustomThumbnailPath.value;
            return isCanReUpload != null
                ? InkWell(
                    onTap: _controller.reUploadButtonClick,
                    child: Container(
                      height: 16,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: CustomColorTheme.secondary40,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          '重新上傳',
                          style: Get.textTheme.labelMedium
                              ?.copyWith(color: CustomColorTheme.secondary99),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  /// 影片預覽區域
  Widget _buildVideoPreview() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '影片預覽',
          style: CustomTextStyle.subtitleSmall
              ?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          height: 270, // 固定高度 270
          child: Obx(() {
            final videoPlayerController =
                _controller.rxnVideoPlayerController.value;
            if (videoPlayerController != null &&
                videoPlayerController.value.isInitialized) {
              return VideoPlayer(videoPlayerController);
            } else {
              // 如果影片未初始化，顯示灰色佔位區域
              return Container(
                width: double.infinity,
                height: 270,
                color: Colors.grey[300],
                child: const Center(
                  child: Text(
                    '無影片預覽',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              );
            }
          }),
        ),
      ],
    );
  }

  /// 下一步按鈕
  Widget _buildNextStepButton(bool isNextButtonClickOn) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 153,
              child: CustomElevatedButton(
                isActive: isNextButtonClickOn,
                text: "下一步",
                onClickEvent: _controller.nextStepButtonClick,
              ),
            ),
          ],
        ),
        const SizedBox(height: 44),
      ],
    );
  }
}
