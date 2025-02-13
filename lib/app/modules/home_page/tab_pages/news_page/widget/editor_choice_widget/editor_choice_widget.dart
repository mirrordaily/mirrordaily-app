import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/editor_choices.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/news_page/widget/editor_choice_widget/editor_choice_widget_controller.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/news_page/widget/editor_choice_widget/slide_item.dart';
import 'package:mirrordaily_app/core/values/string.dart';

class EditorChoiceWidget extends StatelessWidget {
  const EditorChoiceWidget({super.key, required this.editorChoiceList});

  final List<EditorChoice> editorChoiceList;

  @override
  Widget build(BuildContext context) {
    final EditorChoiceWidgetController controller =
        Get.put(EditorChoiceWidgetController(editorChoiceList));

    return SizedBox(
      height: Get.width * 0.55 + 50,
      child: PageView.builder(
        controller: controller.pageController,
        itemCount: editorChoiceList.length,
        itemBuilder: (context, index) {
          return SlideItem(
            editorChoice: editorChoiceList[index],
            controller: controller,
          );
        },
      ),
    );
  }
}
