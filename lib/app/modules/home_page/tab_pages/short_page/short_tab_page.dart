import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/enums/page_status.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/short_page/short_tab_controller.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/short_page/widget/short_item_controller.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/short_page/widget/short_video_item.dart';
import 'package:mirrordaily_app/app/modules/post_short_video_page/post_short_controller.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/routes/routes.dart';

class ShortTabPage extends GetView<ShortTabController> {
  const ShortTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 33,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    controller.fetchShortArticle(sectionSlug: 'news');
                  },
                  child: Obx(() {
                    final currentSection = controller.rxnCurrentSection.value;
                    return Container(
                      alignment: Alignment.center,
                      color: currentSection == 'news'
                          ? CustomColorTheme.primary40
                          : CustomColorTheme.primary99,
                      child: Text(
                        '即時',
                        style: Get.textTheme.bodySmall?.copyWith(
                            color: currentSection == 'news'
                                ? CustomColorTheme.primary95
                                : CustomColorTheme.secondary70),
                      ),
                    );
                  }),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    controller.fetchShortArticle(sectionSlug: 'creativity');
                  },
                  child: Obx(() {
                    final currentSection = controller.rxnCurrentSection.value;
                    return Container(
                      alignment: Alignment.center,
                      color: currentSection == 'creativity'
                          ? CustomColorTheme.primary40
                          : CustomColorTheme.primary99,
                      child: Text(
                        '二創',
                        style: Get.textTheme.bodySmall?.copyWith(
                            color: currentSection == 'creativity'
                                ? CustomColorTheme.primary95
                                : CustomColorTheme.secondary70),
                      ),
                    );
                  }),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () async {

                    controller.pickVideo();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    color: CustomColorTheme.tertiary95,
                    child: Text(
                      '我要投稿',
                      style: Get.textTheme.bodySmall?.copyWith(
                        color: CustomColorTheme.tertiary10,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(() {
          final pageStatus = controller.rxPageStatus.value;
          return pageStatus == PageStatus.normal
              ? Flexible(
                  child: Obx(() {
                    final article = controller.rxCurrentShortArticle.value;
                    return PageView.builder(
                        controller: controller.pageController,
                        scrollDirection: Axis.vertical,
                        itemCount: article.length,
                        itemBuilder: (context, index) {
                          return ShortVideoItem(
                            article: article[index],
                            videoPlayerControllerInitCallBack:
                                (videoPlayerController) {
                              controller.videoPlayerControllerInitCallBackEvent(videoPlayerController);
                            },
                          );
                        });
                  }),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        })
      ],
    );
  }
}
