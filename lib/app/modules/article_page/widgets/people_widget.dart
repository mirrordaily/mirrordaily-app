import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/routes/routes.dart';

class PeopleWidget extends StatelessWidget {
  const PeopleWidget({
    super.key,
    required this.title,
    required this.peopleList,
  });

  final String title;
  final List<Person> peopleList;

  @override
  Widget build(BuildContext context) {
    return peopleList.isNotEmpty
        ? Row(
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: title,
                          style: Get.textTheme.labelMedium?.copyWith(
                            color: CustomColorTheme.natureVariant30,
                            fontSize: 16,
                          ),
                        ),
                        for (int i = 0; i < peopleList.length; i++) ...[
                          TextSpan(
                            text: peopleList[i].name,
                            style: Get.textTheme.labelMedium?.copyWith(
                              color: CustomColorTheme.natureVariant30,
                              fontSize: 16,
                              decoration: TextDecoration.underline, // 可選：加上下底線
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(Routes.writerPage,
                                    arguments: peopleList[i].name);
                              },
                          ),
                          if (i != peopleList.length - 1)
                            const TextSpan(
                              text: ' • ',
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                        ]
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
          ],
        )
        : const SizedBox.shrink();
  }
}
