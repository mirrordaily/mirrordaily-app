import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/home_page/widgets/classfication_page/classification_controller.dart';

class ClassificationPage extends GetView<ClassificationController> {
  const ClassificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('ClassificationPage'),
      ],
    );
  }
}
