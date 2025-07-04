import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/app/data/models/article_preview.dart';
import 'package:mirrordaily_app/core/extensions/date_extension.dart';
import 'package:mirrordaily_app/core/extensions/string_extension.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/values/image_path.dart';
import 'package:mirrordaily_app/core/values/string.dart';

class RelateArticleItem extends StatelessWidget {
  const RelateArticleItem({
    super.key,
    required this.article,
  });

  final ArticlePreview article;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          flex: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 3/2,
                  child: Image.network(
                    article.heroImage?.resized?.w800 ?? '',
                    errorBuilder: (context, error, trace) {
                      return Image.asset(ImagePath.imageDefault);
                    },
                  ),
                ),
                Positioned(
                    left: 8,
                    bottom: 6,
                    child: Container(
                      height: 20,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: article.sections?[0].renderColor, // 背景顏色
                        borderRadius: BorderRadius.circular(8), // ✅ 設定圓角
                      ),
                      child: Text(
                        article.sections?[0].name ?? StringDefault.nullString,
                        style: const TextStyle(fontSize: 10,color: Colors.white),
                      ),
                    ))
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          flex: 1,
          child: Text(
            article.title ?? StringDefault.nullString,
            style: Get.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: CustomColorTheme.nature10,
            ),
          ),
        ),
      ],
    );
  }
}
