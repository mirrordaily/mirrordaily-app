import 'dart:async';

import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/app/data/models/news_marquee.dart';
import 'package:mirrordaily_app/app/data/providers/article_api_provider.dart';
import 'package:mirrordaily_app/app/data/providers/article_gql_provider.dart';
import 'package:mirrordaily_app/routes/routes.dart';

class NewsMarqueeController extends GetxController {
  final ArticleApiProvider articleApiProvider = Get.find();
  final RxList<NewsMarquee> rxNewsMarqueeList = RxList();
  Timer? updateTimer;

  @override
  void onInit() {
    updateNewsMarquee();
  }

  void updateNewsMarquee() async {
     rxNewsMarqueeList.value = await articleApiProvider.getNewsMarquee();


  }


  void goToArticlePage(String? id) {
    if (id == null) return;
    Get.toNamed(Routes.articlePage, arguments: id);
  }
}
