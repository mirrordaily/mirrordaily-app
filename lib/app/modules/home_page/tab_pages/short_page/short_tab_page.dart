import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/enums/page_status.dart';
import 'package:mirrordaily_app/app/data/enums/short_section_type.dart';
import 'package:mirrordaily_app/app/data/enums/short_type.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/short_page/short_tab_controller.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/short_page/widget/short_video_item.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/short_page/widget/short_youtube_item.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../core/values/image_path.dart';

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
                    controller.fetchShortArticle(type: ShortSectionType.news);
                  },
                  child: Obx(() {
                    final type = controller.rxnCurrentType.value;
                    return Container(
                      alignment: Alignment.center,
                      color: type == ShortSectionType.news
                          ? CustomColorTheme.primary40
                          : CustomColorTheme.primary99,
                      child: Text(
                        '即時',
                        style: Get.textTheme.bodySmall?.copyWith(
                            color: type == ShortSectionType.news
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
                    controller.fetchShortArticle(
                        type: ShortSectionType.creativity);
                  },
                  child: Obx(() {
                    final currentSection = controller.rxnCurrentType.value;
                    return Container(
                      alignment: Alignment.center,
                      color: currentSection == ShortSectionType.creativity
                          ? CustomColorTheme.primary40
                          : CustomColorTheme.primary99,
                      child: Text(
                        '投稿',
                        style: Get.textTheme.bodySmall?.copyWith(
                            color: currentSection == ShortSectionType.creativity
                                ? CustomColorTheme.primary95
                                : CustomColorTheme.secondary70),
                      ),
                    );
                  }),
                ),
              ),
              // Expanded(
              //   flex: 1,
              //   child: InkWell(
              //     onTap: () {
              //       controller.pickVideo();
              //     },
              //     child: Container(
              //       alignment: Alignment.center,
              //       color: CustomColorTheme.tertiary95,
              //       child: Text(
              //         '我要投稿',
              //         style: Get.textTheme.bodySmall?.copyWith(
              //           color: CustomColorTheme.tertiary10,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        Obx(() {
          final pageStatus = controller.rxPageStatus.value;
          return pageStatus == PageStatus.normal
              ? Flexible(
                  child: Obx(() {
                    final article = controller.rxCurrentShortArticle.value;
                    return article.isNotEmpty
                        ? Stack(
                            children: [
                              PageView.builder(
                                  controller: controller.pageController,
                                  scrollDirection: Axis.vertical,
                                  itemCount: article.length + 1,
                                  onPageChanged:
                                      controller.onPageViewChangeEvent,
                                  itemBuilder: (context, index) {
                                    if (index == article.length) {
                                      return const Center(
                                          child: Text('你已經看完所有的影片！'));
                                    }
                                    if (article[index].videoSourceType ==
                                        ShortType.youtube) {
                                      final videoId =
                                          YoutubePlayer.convertUrlToId(
                                              article[index].youtubeUrl!);
                                      return videoId != null
                                          ? ShortYoutubeItem(videoId: videoId)
                                          : const SizedBox.shrink();
                                    }

                                    return ShortVideoItem(
                                      article: article[index],
                                      videoPlayerControllerInitCallBack:
                                          (videoPlayerController) {
                                        controller
                                            .videoPlayerControllerInitCallBackEvent(
                                                videoPlayerController);
                                      },
                                    );
                                  }),
                              Positioned(
                                right: 17,
                                bottom: 50,
                                child: Column(
                                  children: [
                                    IconButton(
                                        onPressed: () => controller.shareFacebookButtonClick(),
                                        icon: SvgPicture.asset(
                                            ImagePath.facebookShareIcon)),
                                    IconButton(
                                        onPressed: () => controller.shareLinkButtonClick(),
                                        icon: SvgPicture.asset(
                                            ImagePath.lineShareIcon)),
                                    IconButton(
                                        onPressed: () =>  controller.shareLinkButtonClick(),
                                        icon: SvgPicture.asset(
                                            ImagePath.linkShareIcon))
                                  ],
                                ),
                              )
                            ],
                          )
                        : const Center(child: Text('你已經看完所有的影片！'));
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
