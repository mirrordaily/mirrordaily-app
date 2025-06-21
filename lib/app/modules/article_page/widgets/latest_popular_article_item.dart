import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/article_preview.dart';
import 'package:mirrordaily_app/app/widgets/network_image_widget.dart';
import 'package:mirrordaily_app/core/values/image_path.dart';
import 'package:mirrordaily_app/core/values/string.dart';

class LatestPopularArticleItem extends StatelessWidget {
  const LatestPopularArticleItem({super.key, required this.articlePreview});

  final ArticlePreview articlePreview;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: [
              NetworkImageWidget(
                url: articlePreview.heroImage?.resized?.w800,
              ),

              // Image.network(
              //   articlePreview.heroImage?.resized?.w800 ?? '',
              //   errorBuilder: (context, error, trace) {
              //     return Image.asset(ImagePath.imageDefault);
              //   },
              // ),
              Positioned(
                left: 8,
                bottom: 6,
                child: articlePreview.sections != null &&
                        articlePreview.sections!.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: articlePreview.sections?[0].renderColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Text(
                          articlePreview.sections?[0].name ??
                              StringDefault.nullString,
                          style: Get.textTheme.labelMedium?.copyWith(
                            color: const Color(0xFFF6F6FB),
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: const BoxDecoration(
                          color: Color(0xFF4D8AA4),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Text(
                          '時事',
                          style: Get.textTheme.labelMedium
                              ?.copyWith(color: const Color(0xFFF6F6FB)),
                        ),
                      ),
              )
            ],
          ),
        ),
        Text(articlePreview.title ?? StringDefault.nullString)
      ],
    );
  }
}
