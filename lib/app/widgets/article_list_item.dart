import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/app/data/models/article_preview.dart';
import 'package:mirrordaily_app/app/widgets/network_image_widget.dart';
import 'package:mirrordaily_app/core/extensions/date_extension.dart';
import 'package:mirrordaily_app/core/extensions/string_extension.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/theme/custom_text_style.dart';
import 'package:mirrordaily_app/core/values/string.dart';

class ArticleListItem extends StatelessWidget {
  const ArticleListItem(
      {super.key, required this.article, this.isFirst = false});

  final ArticlePreview article;
  final bool? isFirst;

  @override
  Widget build(BuildContext context) {
    return isFirst == true
        ? Column(
            children: [
              NetworkImageWidget(url: article.heroImage?.resized?.w800),
              const SizedBox(
                height: 8,
              ),
              Text(
                article.title ?? StringDefault.nullString,
                style: Get.textTheme.titleMedium
                    ?.copyWith(color: CustomColorTheme.nature10),
              )
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  article.category != null && article.category!.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: article.sections?[0].renderColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Text(
                            article.category?[0].name ??
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
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    article.publishedDate?.toFormattedYYYYMMDDHHMMSS() ??
                        StringDefault.nullString,
                    style: Get.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                article.title ?? StringDefault.nullString,
                style: CustomTextStyle.subtitleSmall.copyWith(
                    fontWeight: FontWeight.w700,
                    color: CustomColorTheme.nature10),
              ),
            ],
          );
  }
}
