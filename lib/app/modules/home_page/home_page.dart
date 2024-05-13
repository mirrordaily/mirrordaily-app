import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/home_page/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Column(
        children: [Text('hello home')],
      ),
    );
  }
}
