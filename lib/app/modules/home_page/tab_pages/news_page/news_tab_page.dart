import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/enums/choice_type.dart';
import 'package:mirrordaily_app/app/data/enums/news_page_type.dart';
import 'package:mirrordaily_app/app/data/enums/news_type.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/news_page/news_tab_controller.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/news_page/widget/article_list_item.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/news_page/widget/editor_choice_widget/editor_choice_widget.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/news_page/widget/live_stream_widget.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/news_page/widget/tab_content/latest_tab_content.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/news_page/widget/tab_content/topic_tab_content/topic_tab_content.dart';
import 'package:mirrordaily_app/app/widgets/custom_outlined_button.dart';
import 'package:mirrordaily_app/app/widgets/news_marquee_widget/news_marquee_widget.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/theme/custom_text_style.dart';
import 'package:mirrordaily_app/core/values/image_path.dart';
import 'package:mirrordaily_app/core/values/string.dart';
import 'package:mirrordaily_app/routes/routes.dart';

import '../../../../data/models/article.dart';

class NewsTabPage extends GetView<NewsTabController> {
  const NewsTabPage({super.key});

  Widget renderSectionListItem({required Section section}) {
    Color? containerColor;
    if (section.slug == 'topic') {
      containerColor = CustomColorTheme.secondary40;
    } else if (section.slug == 'report') containerColor = Color(0xffFF8D74);

    return Container(
      color: containerColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: InkWell(
          onTap: () {
            controller.onSectionClickEvent(section);
          },
          child: Text(
            section.name ?? StringDefault.nullString,
            style: CustomTextStyle.subtitleSmall.copyWith(
                fontWeight: FontWeight.w700, color: section.renderColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() {
            final sectionList = controller.rxSectionList.value;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: sectionList
                    .map((section) => renderSectionListItem(section: section))
                    .toList(),
              ),
            );
          }),
          NewsMarqueeWidget(),
          const SizedBox(
            height: 16,
          ),
          Obx(
                  (){
                    final newsPageType= controller.rxNewsPageType.value;
              return newsPageType ==NewsPageType.latest? const LatestTabContent():const TopicTabContent();
            }
          ),
        ],
      ),
    );
  }
}
