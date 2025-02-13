import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/home_page/home_controller.dart';

class TabContent extends StatelessWidget {
  const TabContent({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('123312312'),
      ],
    );
  }
}
