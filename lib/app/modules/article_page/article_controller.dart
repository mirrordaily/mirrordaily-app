import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/enums/page_status.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/app/data/models/article_preview.dart';
import 'package:mirrordaily_app/app/data/providers/article_api_provider.dart';
import 'package:mirrordaily_app/app/data/providers/article_gql_provider.dart';
import 'package:mirrordaily_app/app/widgets/dialog_widget.dart';
import 'package:mirrordaily_app/app/widgets/draft_js_widget_factory/draft_js_widget_controller.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';

class ArticleController extends GetxController {
  final ArticleApiProvider articleApiProvider = Get.find();
  final ArticleGqlProvider articleGqlProvider = Get.find();
  final DraftJsWidgetController draftJsWidgetController = Get.find();
  final Rx<PageStatus> rxPageStatus = PageStatus.normal.obs;
  final RxList<ArticlePreview> rxLatestArticleList = RxList();
  final RxList<ArticlePreview> rxPopularArticleList = RxList();
  Article? article;
  bool? isExternal = false;
  final String id;


  ArticleController(this.id);

  @override
  void onInit() async {
    super.onInit();
    rxPageStatus.value = PageStatus.loading;

    article = await articleGqlProvider.getArticleById(id: id);

    if (article == null) {
      await Get.dialog(const DialogWidget(title: 'Error', content: '找不到文章'));
      Get.back();
    } else {
      rxLatestArticleList.value =
          (await articleApiProvider.getLatestArticles()).take(6).toList();
      rxPopularArticleList.value =
          (await articleApiProvider.getPopularArticles()).take(6).toList();
      rxPageStatus.value = PageStatus.normal;
      if (article?.isAdult == true) {
        final adultCheck = await showAdultDialog();
        if (adultCheck == false) Get.back();
      }
    }
  }

  Future<bool> showAdultDialog() async {
    return await Get.dialog(
      Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '您即將進入之內容需滿十八歲方可瀏覽',
                  style: Get.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  '根據「電腦網路內容分級處理辦法」第六條第三款規定，本網站已於各限制級網頁依照台灣網站分級推廣基金會之規定標示。若您尚未年滿十八歲，請點選離開。若您已滿十八歲，亦不可將本區之內容派發、傳閱、出售、出租、交給或借予年齡未滿18歲的人士瀏覽，或將本網站內容向該人士出示、播放或放映。',
                  style: Get.textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(125, 0, 0, 0)),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.back(result: true);
                      },
                      child: Text(
                        '是，我已滿十八歲',
                        style: Get.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: CustomColorTheme.primary20),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back(result: false);
                      },
                      child: Text(
                        '離開',
                        style: Get.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: CustomColorTheme.secondary40),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
