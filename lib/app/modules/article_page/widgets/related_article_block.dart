import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/article_preview.dart';
import 'package:mirrordaily_app/app/modules/article_page/widgets/relate_article_item.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/routes/routes.dart';

class RelatedArticleBlock extends StatelessWidget {
  const RelatedArticleBlock({super.key, required this.articleList});

  final List<ArticlePreview>? articleList;

  @override
  Widget build(BuildContext context) {
    return articleList != null && articleList!.isNotEmpty
        ? Column(
            children: [
              Text(
                '相關新聞',
                style: Get.textTheme.titleMedium
                    ?.copyWith(color: CustomColorTheme.primary40),
              ),
              const SizedBox(
                height: 36,
              ),
              ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.articlePage,
                            arguments: articleList![index].id,
                            preventDuplicates: false);
                      },
                      child: RelateArticleItem(
                        article: articleList![index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 24,
                    );
                  },
                  itemCount: articleList!.length)
            ],
          )
        : const SizedBox.shrink();
  }
}
