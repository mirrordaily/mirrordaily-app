import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/editor_choices.dart';
import 'package:mirrordaily_app/app/data/providers/article_gql_provider.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/news_page/news_tab_controller.dart';

class EditorChoiceWidgetController extends GetxController {
  final PageController pageController = PageController();
  final  RxList<EditorChoice> rxEditorChoiceList=RxList();
  final RxInt rxCurrentPageIndex = 0.obs;
  final ArticleGqlProvider articleGqlProvider =Get.find();
  final NewsTabController newsTabController =Get.find();





  Timer? autoPageViewPlayer;

  @override
  void onInit() async{
    super.onInit();
    rxEditorChoiceList.value = await articleGqlProvider.getEditorChoices();
    autoPageViewPlayer =
        Timer.periodic(const Duration(seconds: 5), (timer){
          nextPage();

        });
  }

  @override
  void onClose() {
    autoPageViewPlayer?.cancel();
  }

  void nextPage() {
    rxCurrentPageIndex.value++;
    if (rxCurrentPageIndex.value >= rxEditorChoiceList.length) {
      rxCurrentPageIndex.value = 0;
    }
    pageController.animateToPage(rxCurrentPageIndex.value,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void prevPage() {
    rxCurrentPageIndex.value--;
    if (rxCurrentPageIndex.value <= 0) {
      rxCurrentPageIndex.value =rxEditorChoiceList.length;
    }
    pageController.animateToPage(rxCurrentPageIndex.value,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }
}
