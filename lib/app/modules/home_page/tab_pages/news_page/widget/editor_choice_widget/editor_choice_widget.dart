import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/editor_choices.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/news_page/widget/editor_choice_widget/editor_choice_widget_controller.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/news_page/widget/editor_choice_widget/slide_item.dart';
import 'package:mirrordaily_app/core/values/string.dart';
import 'package:mirrordaily_app/routes/routes.dart';

class EditorChoiceWidget extends StatelessWidget {
  const EditorChoiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final EditorChoiceWidgetController controller =
        Get.put(EditorChoiceWidgetController());

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 100,
        maxHeight: 350,
      ),
      child: Obx(() {
        final editorChoiceList = controller.rxEditorChoiceList.value;
        return PageView.builder(
          controller: controller.pageController,
          itemCount: editorChoiceList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.toNamed(Routes.articlePage,
                    arguments: editorChoiceList[index].id);
              },
              child: SlideItem(
                editorChoice: editorChoiceList[index],
                controller: controller,
              ),
            );
          },
        );
      }),
    );
  }
}
