import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/enums/apidata_type.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/app/widgets/draft_js_widget_factory/widget/slide_show_widget.dart';
import 'package:mirrordaily_app/app/widgets/draft_js_widget_factory/widget/table_widget.dart';
import 'package:mirrordaily_app/app/widgets/draft_js_widget_factory/widget/video_widget/video_widget.dart';
import 'package:mirrordaily_app/app/widgets/draft_js_widget_factory/widget/youtube_widget/youtube_widget.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/theme/custom_text_style.dart';
import 'package:mirrordaily_app/core/values/image_path.dart';
import 'package:mirrordaily_app/core/values/string.dart';

import 'widget/audio_widget/audio_widget.dart';

class DraftJsWidgetFactory {
  Widget createWidget(ApiData apiData) {
    switch (apiData.type) {
      case ApiDataType.unStyled:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: HtmlWidget(apiData.contentData ?? StringDefault.nullString,
              textStyle: Get.textTheme.bodyLarge),
        );
      case ApiDataType.headerTwo:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: HtmlWidget(
            apiData.contentData ?? StringDefault.nullString,
            textStyle: CustomTextStyle.subtitleLarge,
          ),
        );
      case ApiDataType.headerThree:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: HtmlWidget(
            apiData.contentData ?? StringDefault.nullString,
            textStyle: CustomTextStyle.subtitleMedium,
          ),
        );
      case ApiDataType.blockQuote:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44),
          child: Column(
            children: [
              SvgPicture.asset(
                ImagePath.articleBlockQuote,
                width: 48,
                height: 34,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                apiData.contentData ?? StringDefault.nullString,
                style: Get.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        );
      case ApiDataType.unorderedListItem:
        return apiData.contentList != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(ImagePath.articleUnorderedIcon),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: HtmlWidget(
                              apiData.contentList![index],
                              textStyle: Get.textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 4,
                      );
                    },
                    itemCount: apiData.contentList!.length),
              )
            : const SizedBox.shrink();
      case ApiDataType.orderedListItem:
        return apiData.contentList != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}.',
                            style: Get.textTheme.bodySmall?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF7F8493)),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: HtmlWidget(
                              apiData.contentList![index],
                              textStyle: Get.textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 4,
                      );
                    },
                    itemCount: apiData.contentList!.length),
              )
            : const SizedBox.shrink();
      case ApiDataType.divider:
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        );
      case ApiDataType.audioV2:
        return AudioWidget(
            apiData: apiData); // Implement your audio widget here
      case ApiDataType.image:
        return Column(
          children: [
            Image.network(apiData.contentMap?['resized']['w800']),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    apiData.contentMap?['desc'],
                    style: Get.textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF7C7C81),
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            )
          ],
        );
      case ApiDataType.slideShowV2:
        return SlideShowWidget(imageListMap: apiData.contentMap?['images']);
      case ApiDataType.infoBox:
        return Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            color: CustomColorTheme.secondary90,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 28,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Text(
                      apiData.contentMap?['title'],
                      style: Get.textTheme.bodyMedium
                          ?.copyWith(color: CustomColorTheme.nature20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: HtmlWidget(
                    apiData.contentMap?['body'],
                    textStyle: Get.textTheme.bodyMedium
                        ?.copyWith(color: CustomColorTheme.nature20),
                  ),
                ),
              ],
            ));
      case ApiDataType.table:
        return TableWidget(data: apiData.contentList as List<List<String>>);
      case ApiDataType.embeddedCode:
        double? width = double.tryParse(apiData.contentMap?['width']);
        double? height = double.tryParse(apiData.contentMap?['height']);
        double? aspectRatio;
        if (width != null && height != null) {
          aspectRatio = height / width;
        }
        return SizedBox();
        // return EmbeddedCodeWidget(
        //   embeddedCode: apiData.contentMap?['embeddedCode'],
        //   aspectRatio: aspectRatio,
        // );
      case ApiDataType.youtube:
        return YoutubeWidget(videoUrl: apiData.contentMap?['youtubeId']);
      case ApiDataType.videoV2:
        return VideoWidget(videoUrl: apiData.contentMap?['video']['videoSrc']);
      default:
        return Text(apiData.type.toString());
    }
  }
}
