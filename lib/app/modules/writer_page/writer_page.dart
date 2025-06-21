import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/writer_page/writer_page_controller.dart';
import 'package:mirrordaily_app/app/widgets/fetch_more_button.dart';
import 'package:mirrordaily_app/app/widgets/network_image_widget.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/values/string.dart';
import 'package:mirrordaily_app/routes/routes.dart';

class WriterPage extends GetView<WriterPageController> {
  const WriterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: CustomColorTheme.primary20,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: CustomColorTheme.primary80),
          // 設定返回按鈕顏色
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Obx(() {
          final writerName = controller.rxnWriterName.value;
          return Text(
            writerName ?? StringDefault.nullString,
            style: Get.textTheme.titleLarge?.copyWith(
                color: CustomColorTheme.primary80, fontWeight: FontWeight.w700),
          );
        }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 28,
            ),
            Obx(() {
              final articleList = controller.rxArticleList.value;
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final articlePreview = articleList[index];
                  return InkWell(
                    onTap: () {
                      Get.toNamed(Routes.articlePage,
                          arguments: articlePreview.id);
                    },
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                                width: 160,
                                child: NetworkImageWidget(
                                  url: articlePreview.heroImage?.resized?.w800,
                                  height: 88,
                                  backgroundColor: Colors.white,
                                )),
                            articlePreview.sections != null &&
                                    articlePreview.sections!.isNotEmpty
                                ? Positioned(
                                    bottom: 8, // 距離底部 4px
                                    left: 8, // 距離左側 4px
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: articlePreview
                                            .sections![0].renderColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Text(
                                        articlePreview.sections?[0]?.name ??
                                            StringDefault.nullString,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink()
                          ],
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                articlePreview.formattedCreatedAt ??
                                    StringDefault.nullString,
                                style: Get.textTheme.titleSmall?.copyWith(
                                    color: articlePreview.sections != null &&
                                            articlePreview.sections!.isNotEmpty
                                        ? articlePreview
                                            .sections![0].renderColor
                                        : null,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                articlePreview.title ??
                                    StringDefault.nullString,
                                softWrap: true,
                                maxLines: 10,
                                style: Get.textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
                itemCount: articleList.length,
              );
            }),
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              final isAllArticle = controller.rxIsAllArticle.value;
              return isAllArticle != true
                  ? FetchMoreButton(
                      onClickButton: controller.fetchMoreArticleButtonClick,
                    )
                  : const SizedBox.shrink();
            }),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
