import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mirrordaily_app/app/data/enums/page_status.dart';
import 'package:mirrordaily_app/app/data/models/short_article.dart';
import 'package:mirrordaily_app/app/data/providers/article_gql_provider.dart';
import 'package:mirrordaily_app/app/data/providers/local_cache_provider.dart';
import 'package:mirrordaily_app/routes/routes.dart';
import 'package:video_player/video_player.dart';

class ShortTabController extends GetxController {
  final PageController pageController = PageController();
  final LocalCacheProvider localCacheProvider = Get.find();
  final ArticleGqlProvider articleGqlProvider = Get.find();
  final RxList<ShortArticle> rxCurrentShortArticle = RxList();
  final Rx<PageStatus> rxPageStatus = PageStatus.normal.obs;
  final RxnString rxnCurrentSection = RxnString();
  VideoPlayerController? _videoPlayerController;

  @override
  void onInit() async {
    fetchShortArticle(sectionSlug: 'news');
  }

  void fetchShortArticle({required String sectionSlug}) async {
    if (rxnCurrentSection.value == sectionSlug) return;
    rxPageStatus.value = PageStatus.loading;
    rxnCurrentSection.value = sectionSlug;
    rxCurrentShortArticle.clear();
    var shortList = await articleGqlProvider.getShortArticleBySectionSlug(
        slug: sectionSlug);

    final watchedList =localCacheProvider.watchedVideoList;
    shortList.removeWhere((element) {
      for(var watched in watchedList){
        if(watched.id == element.id) {
          return true;
        }
      }
      return false;
    });


    rxCurrentShortArticle.value = shortList;
    Future.delayed(const Duration(milliseconds: 500), () {
      rxPageStatus.value = PageStatus.normal;
    });
  }

  void videoPlayerControllerInitCallBackEvent(
      VideoPlayerController? videoPlayerController) {
    _videoPlayerController = videoPlayerController;
  }



  Future<void> pickVideo() async {
    _videoPlayerController?.pause();
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      Get.toNamed(Routes.postShortVideoPage, arguments: pickedFile);
    }
  }
}
