import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mirrordaily_app/app/data/enums/short_preview_source.dart';
import 'package:mirrordaily_app/app/data/models/post_short_package.dart';
import 'package:mirrordaily_app/app/data/providers/article_gql_provider.dart';
import 'package:mirrordaily_app/routes/routes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path/path.dart' as p;

class PostShortVideoController extends GetxController {
  final ArticleGqlProvider articleGqlProvider = Get.find();
  final Rxn<VideoPlayerController> rxnVideoPlayerController = Rxn();
  final RxnString rxnAutoThumbnailPath = RxnString();
  final RxnString rxnCustomThumbnailPath = RxnString();
  final TextEditingController titleTextEditingController =
      TextEditingController();
  final TextEditingController videoExplanationTextEditingController =
      TextEditingController();
  final Rx<ShortPreviewSource> rxShortPreviewSource =
      ShortPreviewSource.auto.obs;
  final RxBool isNextButtonClickOn = false.obs;

  XFile? videoXFile;
  final picker = ImagePicker();

  int? customPhotoId;
  int? autoPhotoId;

  String? _title;
  String? _videoExplanation;

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      videoXFile = Get.arguments;
    }

    if (videoXFile == null) Get.back();
    final fileSize = await videoXFile!.length();
    if (fileSize > 30000000) {
      Get.snackbar('Mirror Daily', '檔案超過 30M');
      Get.back();
    }
    if (videoXFile != null) {
      String filePath = videoXFile!.path;
      String fileName = p.basename(filePath);
      titleTextEditingController.text = fileName;
      _title = fileName;
    }

    generateThumbnail(videoXFile!.path);
    _initializeVideoPlayer();

    titleTextEditingController.addListener(titleTextChangeEvent);
    videoExplanationTextEditingController
        .addListener(videoExplanationChangeEvent);
  }

  void titleTextChangeEvent() {
    _title = titleTextEditingController.text;
    checkValueIsFull();
  }

  void videoExplanationChangeEvent() {
    _videoExplanation = videoExplanationTextEditingController.text;
    checkValueIsFull();
  }

  void checkValueIsFull() {
    isNextButtonClickOn.value =
        _videoExplanation!.isNotEmpty && _title!.isNotEmpty;
  }

  Future<void> generateThumbnail(String path) async {
    rxnAutoThumbnailPath.value = await VideoThumbnail.thumbnailFile(
      video: path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 200,
      // specify the height of the thumbnail
      quality: 75,
    );
  }

  Future<void> _initializeVideoPlayer() async {
    rxnVideoPlayerController.value =
        VideoPlayerController.file(File(videoXFile!.path));
    await rxnVideoPlayerController.value?.initialize();
    rxnVideoPlayerController.value?.setLooping(true);
    rxnVideoPlayerController.value?.play();
    rxnVideoPlayerController.update((val) {});
  }

  Future<File?> selectImageFile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path); // 返回選中的 File 物件
    } else {
      return null; // 如果沒有選取圖片，返回 null
    }
  }

  void selectCustomThumbnail() async {
    if (rxnCustomThumbnailPath.value != null) {
      rxShortPreviewSource.value = ShortPreviewSource.customer;
    } else {
      reUploadButtonClick();
    }
  }

  void reUploadButtonClick() async {
    File? imageFile = await selectImageFile();
    rxnCustomThumbnailPath.value = imageFile?.path;
  }

  void nextStepButtonClick() {
    if (_title == null || _title!.isEmpty) {
      return;
    }
    PostShortPackage package = PostShortPackage(
        title: _title,
        description: _videoExplanation,
        videoXFile: videoXFile,
        imagePreviewPath:
            rxShortPreviewSource.value == ShortPreviewSource.customer
                ? rxnCustomThumbnailPath.value
                : rxnAutoThumbnailPath.value);
    Get.toNamed(Routes.postShortVideoUserCheckPage, arguments: package);
  }

  void autoPreviewImageClick() {
    rxShortPreviewSource.value = ShortPreviewSource.auto;
  }

  @override
  void dispose() {
    rxnVideoPlayerController.value?.pause();
    rxnVideoPlayerController.value?.dispose();
    super.dispose();
  }
}
