import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/spill_the_tea_page/spill_the_tea_controller.dart';

class SpillTheTeaPage extends GetView<SpillTheTeaController> {
  const SpillTheTeaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('hello SpillTheTeaPage'),
      ],
    );
  }
}
