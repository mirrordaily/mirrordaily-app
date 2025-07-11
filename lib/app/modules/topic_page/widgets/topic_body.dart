import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/enums/topic_type.dart';
import 'package:mirrordaily_app/app/data/models/topic.dart';
import 'package:mirrordaily_app/core/theme/custom_text_style.dart';
import 'package:mirrordaily_app/routes/routes.dart';

import '../../../../core/values/string.dart';

class TopicBody extends StatelessWidget {
  const TopicBody({super.key, required this.topic});

  final Topic topic;

  Widget renderListPost(List<Posts> postList) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.toNamed(Routes.articlePage,
                      arguments: postList[index].id);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4), // 圓角
                        child: Image.network(
                          postList[index].heroImage?.resized?.w800 ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(StringDefault.imageDefaultUrl);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      postList[index].title ?? StringDefault.nullString,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyle.subtitleMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF4A4A4A)),
                    ),
                    postList[index].subtitle != null
                        ? Text(
                            postList[index].subtitle ?? '',
                            style: Get.textTheme.titleSmall
                                ?.copyWith(color: const Color(0xFF4A4A4A)),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      postList[index].briefText ?? '',
                      style: CustomTextStyle.subtitleSmall.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 36,
              );
            },
            itemCount: postList.length));
  }

  Widget renderGroupItem(List<Posts> postList) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.toNamed(Routes.articlePage, arguments: postList[index].id);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  color: Colors.black,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), // 圓角
                    child: Image.network(
                      postList[index].heroImage?.resized?.w800 ?? '',
                      fit: BoxFit.fitHeight,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(StringDefault.imageDefaultUrl);
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  postList[index].title ?? StringDefault.nullString,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyle.subtitleMedium
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                postList[index].subtitle != null
                    ? Text(
                        postList[index].subtitle ?? '',
                        style: Get.textTheme.titleSmall
                            ?.copyWith(color: const Color(0xFF4A4A4A)),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      )
                    : const SizedBox.shrink(),
                Text(
                  postList[index].briefText ?? '',
                  style: CustomTextStyle.subtitleSmall.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 36,
          );
        },
        itemCount: postList.length);
  }

  Widget renderGroup(Topic topic) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final key = topic.getGroupPost.keys.map((e) => e).toList()[index];
            final postList = topic.getGroupPost[key];
            return Column(
              children: [
                postList != null && postList.isNotEmpty
                    ? Text(
                        key,
                        style: CustomTextStyle.subtitleLarge
                            .copyWith(fontWeight: FontWeight.w700),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  height: 24,
                ),
                renderGroupItem(postList ?? [])
              ],
            );
          },
          separatorBuilder: (context, index) {
            return const Column(
              children: [
                Divider(),
                SizedBox(
                  height: 24,
                )
              ],
            );
          },
          itemCount: topic.getGroupPost.keys.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return topic.type == TopicType.list
        ? renderListPost(topic.posts)
        : renderGroup(topic);
  }
}
