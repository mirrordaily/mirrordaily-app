import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/topic_page/topic_page_controller.dart';
import 'package:mirrordaily_app/app/modules/topic_page/widgets/topic_body.dart';
import 'package:mirrordaily_app/app/modules/topic_page/widgets/topic_leading.dart';
import 'package:mirrordaily_app/core/theme/custom_text_style.dart';
import 'package:mirrordaily_app/core/values/string.dart';

class TopicPage extends GetView<TopicPageController> {
  const TopicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final title = controller.rxnTopicPreview.value?.name;
          return Text(title ?? StringDefault.nullString);
        }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///因需求 暫時隱藏Topic 的標頭
            // Obx(() {
            //   final topic = controller.rxnTopic.value;
            //   return topic != null
            //       ? TopicLeading(topic: topic)
            //       : const SizedBox.shrink();
            // }),
            const SizedBox(
              height: 36,
            ),
            Obx(() {
              final topic = controller.rxnTopic.value;
              return topic != null
                  ? TopicBody(topic: topic)
                  : const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}
