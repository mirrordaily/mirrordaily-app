import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/enums/page_status.dart';
import 'package:mirrordaily_app/app/modules/post_short_video_page/post_short_video_result_page/post_short_video_result_controller.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/theme/custom_text_style.dart';
import 'package:mirrordaily_app/routes/routes.dart';

class PostShortVideoResultPage extends GetView<PostShortVideoResultController> {
  const PostShortVideoResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('短影音投稿'),
      ),
      body: Obx(() {
        final isLoading = controller.rxPageStatus.value;
        return isLoading == PageStatus.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Obx(() {
                    final isSuccessful = controller.rxIsUploadSuccessful.value;
                    return Center(
                      child: isSuccessful
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '送出成功！',
                                  style: CustomTextStyle.subtitleMedium
                                      .copyWith(
                                          fontSize: 16,
                                          color: CustomColorTheme.secondary10),
                                ),
                                Text('影片審核完成後，將會寄送通知',
                                    style: CustomTextStyle.subtitleMedium
                                        .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                CustomColorTheme.secondary50))
                              ],
                            )
                          : Text(
                              '上傳失敗',
                              style: CustomTextStyle.subtitleSmall.copyWith(
                                  fontSize: 16,
                                  color: CustomColorTheme.error60),
                            ),
                    );
                  }),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 153,
                            height: 36,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor: CustomColorTheme.primary30,
                                  foregroundColor:
                                      CustomColorTheme.secondary90),
                              onPressed: () {
                                Get.offNamedUntil(Routes.homePage,ModalRoute.withName('/home'));
                              },
                              child: Text(
                                '回到短影音',
                                style: Get.textTheme.labelLarge?.copyWith(
                                    color: CustomColorTheme.secondary90),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 42,
                      )
                    ],
                  )
                ],
              );
      }),
    );
  }
}
