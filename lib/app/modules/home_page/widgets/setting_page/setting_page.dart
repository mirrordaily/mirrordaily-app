import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/home_page/widgets/setting_page/setting_controller.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Setting Page'),
      ],
    );
  }
}
