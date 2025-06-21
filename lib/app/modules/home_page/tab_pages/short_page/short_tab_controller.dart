import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mirrordaily_app/app/data/enums/page_status.dart';
import 'package:mirrordaily_app/app/data/enums/short_section_type.dart';
import 'package:mirrordaily_app/app/data/enums/short_type.dart';
import 'package:mirrordaily_app/app/data/models/short_article.dart';
import 'package:mirrordaily_app/app/data/providers/article_gql_provider.dart';
import 'package:mirrordaily_app/app/data/providers/local_cache_provider.dart';
import 'package:mirrordaily_app/app/data/providers/short_api_provider.dart';
import 'package:mirrordaily_app/configs/environment.dart';
import 'package:mirrordaily_app/routes/routes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class ShortTabController extends GetxController {
  final PageController pageController = PageController();
  final LocalCacheProvider localCacheProvider = Get.find();
  final ArticleGqlProvider articleGqlProvider = Get.find();
  final RxList<ShortArticle> rxCurrentShortArticle = RxList();
  final Rx<PageStatus> rxPageStatus = PageStatus.normal.obs;

  VideoPlayerController? _videoPlayerController;

  final Rxn<ShortSectionType> rxnCurrentType = Rxn();
  final ShortApiProvider shortApiProvider = Get.find();
  int currentPageIndex = 0;

  @override
  void onInit() async {
    super.onInit();
    await fetchShortArticle(type: ShortSectionType.news);
  }

  Future<void> fetchShortArticle({required ShortSectionType type}) async {
    if (rxnCurrentType.value == type) return;
    rxnCurrentType.value = type;
    rxPageStatus.value = PageStatus.loading;
    rxnCurrentType.value = type;
    rxCurrentShortArticle.clear();

    final shortList = type == ShortSectionType.news
        ? await shortApiProvider.getRealTimeShort()
        : await shortApiProvider.getCreativityShort();
    final watchedList = localCacheProvider.watchedVideoList;
    shortList.removeWhere((element) {
      for (var watched in watchedList) {
        if (watched.id == element.id ||
            element.videoUrl == null ||
            element.videoSourceType == ShortType.youtube) {
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

  Future<bool> requestFilePermission() async {
    if (await Permission.photos.request().isGranted ||
        await Permission.storage.request().isGranted) {
      return true;
    } else if (await Permission.storage.isPermanentlyDenied) {
      await Get.dialog(AlertDialog(
        title: const Text('權限被拒絕'),
        content: const Text('請前往設定開啟影片存取權限'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              await openAppSettings(); // 導航至系統設定頁
            },
            child: const Text('前往設定'),
          ),
        ],
      ));
    } else {
      debugPrint("Permission denied temporarily");
      Get.snackbar('Mirror daily', '請授權以使用影片選擇功能');
    }
    return false;
  }

  Future<void> pickVideo() async {
    _videoPlayerController?.pause();
    final havePermission = await requestFilePermission();
    if (havePermission == false) return;

    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      Get.toNamed(Routes.postShortVideoPage, arguments: pickedFile);
    }
  }

  void onPageViewChangeEvent(int? index) {
    if (index == null) return;
    currentPageIndex = index;
  }

  void shareLineButtonClick() async {
    String? id  =rxCurrentShortArticle[currentPageIndex].id;
    if (id == null) return;
    final lineUrl =
        "https://social-plugins.line.me/lineit/share?url=${Environment().config.shortApiPath}$id";
    ;
    if (await canLaunchUrl(Uri.parse(lineUrl))) {
      await launchUrl(Uri.parse(lineUrl), mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch LINE share.");
    }
  }

  void shareFacebookButtonClick() async {
    String? id  =rxCurrentShortArticle[currentPageIndex].id;
    final facebookUrl =
        "https://www.facebook.com/sharer/sharer.php?u=${Environment().config.shortApiPath}$id";
    if (await canLaunchUrl(Uri.parse(facebookUrl))) {
      await launchUrl(Uri.parse(facebookUrl),
          mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch Facebook share.");
    }
  }

  void shareLinkButtonClick() {
    String? id  =rxCurrentShortArticle[currentPageIndex].id;
    Clipboard.setData(
        ClipboardData(text: '${Environment().config.shortApiPath}$id'));
    Get.snackbar('鏡報', '已複製連結');
  }
}
