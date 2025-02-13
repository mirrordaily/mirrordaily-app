import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/editor_choices.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/news_page/widget/editor_choice_widget/editor_choice_widget_controller.dart';
import 'package:mirrordaily_app/configs/environment.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/values/image_path.dart';
import 'package:mirrordaily_app/core/values/string.dart';

class SlideItem extends StatelessWidget {
  const SlideItem({
    super.key,
    required this.editorChoice,
    required this.controller,
  });

  final EditorChoice editorChoice;
  final EditorChoiceWidgetController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
                width: Get.width,
                height: Get.width * 0.55,
                child: editorChoice.heroImage?.resized?.w800 != null &&
                        editorChoice.heroImage?.resized?.w800 != ''
                    ? Image.network(
                        editorChoice.heroImage!.resized!.w800!,
                        fit: BoxFit.fitWidth,
                      )
                    : Image.asset(ImagePath.imageDefault)),
            Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                InkWell(
                    onTap: () {
                      controller.prevPage();
                    },
                    child: SvgPicture.asset(ImagePath.arrowLeftIcon)),
                const Spacer(),
                InkWell(
                    onTap: () {
                      controller.nextPage();
                    },
                    child: SvgPicture.asset(ImagePath.arrowRightIcon)),
                const SizedBox(
                  width: 16,
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            editorChoice.choices?.title ?? StringDefault.nullString,
            style: Get.textTheme.titleMedium
                ?.copyWith(color: CustomColorTheme.nature10),
          ),
        ),
      ],
    );
  }
}
