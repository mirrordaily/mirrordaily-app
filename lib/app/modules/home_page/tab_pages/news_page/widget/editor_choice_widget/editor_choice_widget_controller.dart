import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/editor_choices.dart';

class EditorChoiceWidgetController extends GetxController {
  final PageController pageController = PageController();
  final List<EditorChoice> editorChoiceList;
  final RxInt rxCurrentPageIndex = 0.obs;

  EditorChoiceWidgetController(this.editorChoiceList);


  @override
  void onInit() {

  }

  void nextPage() {
    rxCurrentPageIndex.value++;
    if (rxCurrentPageIndex.value == editorChoiceList.length) {
      rxCurrentPageIndex.value = editorChoiceList.length - 1;
    }
    pageController.animateToPage(rxCurrentPageIndex.value,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void prevPage() {
    rxCurrentPageIndex.value--;
    if (rxCurrentPageIndex.value == 0) {
      rxCurrentPageIndex.value = 0;
    }
    pageController.animateToPage(rxCurrentPageIndex.value,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }
}
