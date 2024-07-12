import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';

class PeopleWidget extends StatelessWidget {
  const PeopleWidget(
      {super.key, required this.title, required this.peopleList});

  final String title;
  final List<Person> peopleList;

  @override
  Widget build(BuildContext context) {
    return peopleList.isNotEmpty
        ? Column(
            children: [
              RichText(
                text: TextSpan(
                  text: title,
                  style: Get.textTheme.labelMedium?.copyWith(
                      color: CustomColorTheme.natureVariant30, fontSize: 16),
                  children: [
                    for (var person in peopleList) ...[
                      TextSpan(
                        text: '${person.name}',
                        style: Get.textTheme.labelMedium?.copyWith(
                            color: CustomColorTheme.natureVariant30,
                            fontSize: 16),
                      ),
                      const TextSpan(
                        text: ' • ',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ]
                  ],
                ),
                softWrap: true,
              ),
              const SizedBox(
                height: 4,
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
