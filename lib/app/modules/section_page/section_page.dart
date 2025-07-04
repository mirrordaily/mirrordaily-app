import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/section_page/section_page_controller.dart';
import 'package:mirrordaily_app/app/modules/section_page/widgets/article_list_item.dart';
import 'package:mirrordaily_app/app/widgets/fetch_more_button.dart';
import 'package:mirrordaily_app/app/widgets/news_marquee_widget/news_marquee_widget.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/theme/custom_text_style.dart';
import 'package:mirrordaily_app/core/values/string.dart';
import 'package:mirrordaily_app/routes/routes.dart';

class SectionPage extends GetView<SectionPageController> {
  const SectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.rxnSection.value?.name ?? StringDefault.nullString,
          style: CustomTextStyle.subtitleLarge.copyWith(
              fontWeight: FontWeight.w700,
              color: controller.rxnSection.value?.renderColor),
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: controller.rxnSection.value?.renderColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              final categoryList = controller.rxnCategoryList;
              if (categoryList.isEmpty) return const SizedBox.shrink();
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categoryList
                      .map((category) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            child: InkWell(
                              onTap: () => controller.categorySelectEvent(category),
                              child: Obx(() {
                                final selectCategory = controller.rxSelectCategory.value;
                                return Text(
                                  category.name ?? StringDefault.nullString,
                                  style: CustomTextStyle.subtitleSmall.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: selectCategory?.slug == category.slug
                                          ? controller.sectionColor
                                          : CustomColorTheme.secondary70),
                                );
                              }),
                            ),
                          ))
                      .toList(),
                ),
              );
            }),
            const SizedBox(
              height: 28,
            ),
            Obx(() {
              final articleList = controller.rxArticleList.value;
              return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.articlePage,
                            arguments: articleList[index].id);
                      },
                      child: ArticleListItem(
                        article: articleList[index],
                        mainColor: controller.sectionColor,
                        isFirst: index == 0,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: index == 0 ? 40 : 20);
                  },
                  itemCount: articleList.length);
            }),
            Obx(
                    (){
                      final isAllArticle =controller.rxIsAllArticle.value;
                return isAllArticle?const SizedBox.shrink(): Center(
                    child: FetchMoreButton(
                        onClickButton: controller.fetchMoreButtonClick));
              }
            ),
            const SizedBox(
              height: 150,
            )
          ],
        ),
      ),
    );
  }
}
