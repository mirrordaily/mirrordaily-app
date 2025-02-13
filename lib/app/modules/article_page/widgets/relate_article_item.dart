import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
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

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          flex: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              article.heroImage?.resized?.w800 ?? '',
              errorBuilder: (context, error, trace) {
                return Image.asset(ImagePath.imageDefault);
              },
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.createdAt?.toFormattedYYYYMMDDHHMMSS() ??
                    StringDefault.nullString,
                style: Get.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: CustomColorTheme.primary40),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                article.title ?? StringDefault.nullString,
                style: Get.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: CustomColorTheme.nature10),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
