import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/external_article.dart';
import 'package:mirrordaily_app/app/modules/article_page/external_article_page/external_article_controller.dart';
import 'package:mirrordaily_app/app/modules/article_page/widgets/latest_popular_article_block.dart';
import 'package:mirrordaily_app/app/modules/article_page/widgets/related_article_block.dart';
import 'package:mirrordaily_app/app/widgets/network_image_widget.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/theme/custom_text_style.dart';
import 'package:mirrordaily_app/core/values/string.dart';
import 'package:mirrordaily_app/routes/routes.dart';

class ExternalArticlePage extends GetView<ExternalArticleController> {
  ExternalArticlePage({super.key});

  final String id = Get.arguments;

  @override
  String? get tag => id;

  Widget renderExternalArticleBody(ExternalArticle article) {
    return Column(
      children: [
        article.sectionList!.isNotEmpty
            ? Text(
                article.sectionList![0].name ?? StringDefault.nullString,
                style: Get.textTheme.labelLarge
                    ?.copyWith(color: article.sectionList![0].renderColor),
              )
            : const SizedBox.shrink(),
        const SizedBox(
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.title ?? StringDefault.nullString,
                style: Get.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                article.publishedDateString ?? StringDefault.nullString,
                style: CustomTextStyle.footNode,
              ),
              Text(
                '記者：${article.extendByline}',
                style: CustomTextStyle.footNode,
              ),
              const SizedBox(
                height: 24,
              ),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 8,
                runSpacing: 8,
                children: article.tagList!
                    .map((e) => InkWell(
                          onTap: () {
                            Get.toNamed(Routes.tagPage, arguments: e.name);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: CustomColorTheme.secondary90,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: Text(
                              e.name ?? StringDefault.nullString,
                              style: Get.textTheme.labelLarge?.copyWith(
                                color: CustomColorTheme.natureVariant50,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
        NetworkImageWidget(
          url: article.thumb,
        ),
        const SizedBox(
          height: 28,
        ),
        Container(
            color: CustomColorTheme.primary60,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: HtmlWidget(
              article.brief ?? StringDefault.nullString,
              textStyle: Get.textTheme.bodyMedium,
            )),
        const SizedBox(
          height: 28,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: HtmlWidget(article.content ?? StringDefault.nullString),
        ),
        const SizedBox(
          height: 28,
        ),
        RelatedArticleBlock(
            articleList:
                controller.rxnExternalArticle.value?.relatedArticleList ?? []),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 60,horizontal: 60),
          child: Divider(),
        ),
        LatestPopularArticleBlock(
            articleList: controller.rxLatestArticleList.value),
        const SizedBox(
          height: 60,
        ),
        LatestPopularArticleBlock(
          articleList: controller.rxPopularArticleList.value,
          isLatest: false,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Obx(() {
              final externalArticle = controller.rxnExternalArticle.value;
              return externalArticle != null
                  ? renderExternalArticleBody(externalArticle)
                  : const SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }
}
