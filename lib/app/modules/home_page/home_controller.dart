import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/routes/routes.dart';

class HomeController extends GetxController {
  final RxInt rxCurrentBottomIndex = 0.obs;
  final TextEditingController textEditingController = TextEditingController();

  void onBottomNavigationItemClick(int index) {
    if (index == rxCurrentBottomIndex.value) {
      return;
    }
    rxCurrentBottomIndex.value = index;
    final targetPage = Routes.bottomNavigationPages[index];
    Get.toNamed(targetPage, id: Routes.navigationBarKey);
  }

  void goToArticlePage() {
    Get.toNamed(Routes.articlePage);
  }
}
