import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/routes/routes.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final Rxn<TabController> rxnTabController = Rxn();
  final RxInt rxSelectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    rxnTabController.value = TabController(length: 2, vsync: this);

    rxnTabController.value?.addListener(() {
      rxSelectedIndex.value = rxnTabController.value!.index;
    });
  }

  void onSearchButtonClick() {
    Get.toNamed(Routes.searchPage);
  }
}
