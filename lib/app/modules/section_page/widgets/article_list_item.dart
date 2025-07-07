import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/app/data/models/article_preview.dart';
import 'package:mirrordaily_app/core/extensions/string_extension.dart';
import 'package:mirrordaily_app/core/values/image_path.dart';
import 'package:mirrordaily_app/core/values/string.dart';

class ArticleListItem extends StatelessWidget {
  const ArticleListItem(
      {super.key,
      required this.article,
      required this.mainColor,
      this.isFirst = false});

  final ArticlePreview article;
  final bool? isFirst;
  final Color? mainColor;

  @override
  Widget build(BuildContext context) {
    return isFirst == true
        ? Column(
            children: [
              article.heroImage?.resized?.w800 != null
                  ? Image.network(
                      article.heroImage!.resized!.w800!,
                      errorBuilder: (context, object, trace) {
                        return Image.asset(ImagePath.imageDefault);
                      },
                    )
                  : Image.asset(ImagePath.imageDefault),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      width: 30,
                      color: mainColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        article.title ?? StringDefault.nullString,
                        style: Get.textTheme.titleMedium
                            ?.copyWith(color: mainColor),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: AspectRatio(
                      aspectRatio: 3 / 2,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: article.heroImage?.resized?.w800 != null
                              ? Image.network(article.heroImage!.resized!.w800!)
                              : Image.asset(ImagePath.imageDefault)),
                    )),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        article.publishedDate?.toFormattedYYYYMMDDHHMMSS() ??
                            StringDefault.nullString,
                        style: Get.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700, color: mainColor),
                      ),
                      Text(article.title ?? StringDefault.nullString,
                          style: Get.textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700)),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
