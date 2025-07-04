import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/news_page/widget/tab_content/topic_tab_content/topic_tab_controller.dart';
import 'package:mirrordaily_app/core/theme/custom_text_style.dart';
import 'package:mirrordaily_app/core/values/string.dart';
import 'package:mirrordaily_app/routes/routes.dart';

class TopicTabContent extends GetView<TopicTabController> {
  const TopicTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 23),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => controller.onTopicPreviewItemClick(
                  controller.rxTopicPreviewList[index]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  AspectRatio(
                    aspectRatio: 3/2,// 或你想要的比例
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        controller.rxTopicPreviewList[index].heroImage?.resized?.w800 ??
                            StringDefault.imageDefaultUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, object, e) {
                          return Image.asset(StringDefault.imageDefaultUrl, fit: BoxFit.cover);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    controller.rxTopicPreviewList[index].name ??
                        StringDefault.nullString,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyle.subtitleLarge
                        .copyWith(fontWeight: FontWeight.w700),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 40);
          },
          itemCount: controller.rxTopicPreviewList.length),
    );
  }
}
