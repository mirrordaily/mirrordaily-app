import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/post_short_video_page/post_short_video_user_check_page/post_short_video_user_check_controller.dart';
import 'package:mirrordaily_app/app/widgets/custom_elevated_button.dart';
import 'package:mirrordaily_app/app/widgets/custom_text_field.dart';
import 'package:mirrordaily_app/app/widgets/custom_text_form_field.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/theme/custom_text_style.dart';

class PostShortVideoUserCheckPage
    extends GetView<PostShortVideoUserCheckController> {
  const PostShortVideoUserCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('短影音投稿'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 36,
              ),

              Obx(() {
                final previewImagePath = controller.rxImagePath.value;
                return previewImagePath != null
                    ? Image.file(
                        File(previewImagePath),
                        width: Get.width * 0.4,
                        height: Get.width * 0.4 * 1.77,
                      )
                    : Container(
                        width: Get.width * 0.4,
                        height: Get.width * 0.4 * 1.77,
                        color: Colors.grey,
                      );
              }),
              const SizedBox(
                height: 48,
              ),
              Text(
                '投稿暱稱',
                style: CustomTextStyle.subtitleSmall.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: CustomColorTheme.secondary10),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: Get.width * 0.5,
                child: CustomTextFormField(
                  controller: controller.nameTextEditingController,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'email',
                    style: CustomTextStyle.subtitleSmall.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: CustomColorTheme.secondary10),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    '(必填)',
                    style: CustomTextStyle.subtitleSmall.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: CustomColorTheme.secondary50),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: Get.width * 0.5,
                child: CustomTextField(
                  controller: controller.emailTextEditingController,
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    final isAgreeToLicenseVideo =
                        controller.rxIsAgreeToLicenseVideo.value;
                    return Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        value: isAgreeToLicenseVideo,
                        onChanged: controller.isAgreeToLicenseVideoChange);
                  }),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '同意將影片授權予鏡報',
                    style: Get.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: CustomColorTheme.secondary10),
                  )
                ],
              ),
              // const SizedBox(
              //   height: 8,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    final isContentCopyrightCompliant =
                        controller.rxIsContentCopyrightCompliant.value;
                    return Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        value: isContentCopyrightCompliant,
                        onChanged:
                            controller.isContentCopyrightCompliantChange);
                  }),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '確認內容無違反著作權',
                    style: Get.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: CustomColorTheme.secondary10),
                  ),
                ],
              ),
              const SizedBox(
                height: 28,
              ),
              Obx(() {
                final isErrorDisplay =
                    controller.rxIsLicenseCopyrightErrorDisplay.value;
                return isErrorDisplay == true
                    ? Text(
                        '請勾選同意授權與著作權確認！',
                        style: Get.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: CustomColorTheme.error60,
                        ),
                      )
                    : const SizedBox.shrink();
              }),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 153,
                        child: Obx(() {
                          final isNextButtonClickOn =
                              controller.rxIsNextButtonClickOn.value;
                          return CustomElevatedButton(
                            isActive: isNextButtonClickOn,
                            text: "下一步",
                            onClickEvent: () {
                              controller.sentFormResult();
                              // Get.toNamed(Routes.postShortVideoUserCheckPage);
                            },
                          );
                        }),
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
      ),
    );
  }
}
