import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/enums/choice_type.dart';
import 'package:mirrordaily_app/app/data/enums/news_type.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/news_page/news_tab_controller.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/news_page/widget/article_list_item.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/news_page/widget/editor_choice_widget/editor_choice_widget.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/news_page/widget/live_stream_widget.dart';
import 'package:mirrordaily_app/app/widgets/custom_outlined_button.dart';
import 'package:mirrordaily_app/core/values/string.dart';
import 'package:mirrordaily_app/routes/routes.dart';

class LatestTabContent extends StatelessWidget {
  const LatestTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NewsTabController>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              final type = controller.rxChoiceSelectType.value;
              return CustomOutlinedButton(
                text: '編輯精選',
                isSelect: type == ChoiceType.editor,
                onClickEvent: () {
                  controller.choiceTypeClickEvent(ChoiceType.editor);
                },
              );
            }),
            const SizedBox(
              width: 8,
            ),
            Obx(() {
              final type = controller.rxChoiceSelectType.value;
              return CustomOutlinedButton(
                text: 'AI 精選',
                isSelect: type == ChoiceType.ai,
                onClickEvent: () =>
                    controller.choiceTypeClickEvent(ChoiceType.ai),
              );
            }),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Obx(() {
          final editorChoiceList = controller.rxEditorChoiceList.value;
          return EditorChoiceWidget(editorChoiceList: editorChoiceList);
        }),
        Obx(() {
          final liveStreamLink = controller.rxnLiveStreamLink.value;
          final youtubePlayerController =
              controller.rxnYoutubePlayerController.value;
          return liveStreamLink != null && youtubePlayerController != null
              ? LiveStreamWidget(
                  title: liveStreamLink.name ?? StringDefault.nullString,
                  ytPlayer: youtubePlayerController,
                )
              : Container();
        }),
        const SizedBox(
          height: 32,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              final type = controller.rxNewsType.value;
              return CustomOutlinedButton(
                text: '即時新聞',
                isSelect: type == NewsType.realTime,
                onClickEvent: () {
                  controller.newsTypeClickEvent(NewsType.realTime);
                },
              );
            }),
            const SizedBox(
              width: 8,
            ),
            Obx(() {
              final type = controller.rxNewsType.value;
              return CustomOutlinedButton(
                text: '熱門新聞',
                isSelect: type == NewsType.popular,
                onClickEvent: () =>
                    controller.newsTypeClickEvent(NewsType.popular),
              );
            }),
          ],
        ),
        const SizedBox(
          height: 28,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Obx(() {
            final renderArticleList = controller.rxRenderArticleList.value;
            return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(Routes.articlePage,
                          arguments: renderArticleList[index].slug);
                    },
                    child: ArticleListItem(
                      article: renderArticleList[index],
                      isFirst: index == 0,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return index == 0
                      ? const SizedBox(
                          height: 28,
                        )
                      : const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(),
                        );
                },
                itemCount: renderArticleList.length);
          }),
        ),
        OutlinedButton(
            onPressed: () {
              controller.test();
            },
            child: const Text('Article page')),
      ],
    );
  }
}
