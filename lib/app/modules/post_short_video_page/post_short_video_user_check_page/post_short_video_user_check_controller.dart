import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/post_short_package.dart';
import 'package:mirrordaily_app/routes/routes.dart';

class PostShortVideoUserCheckController extends GetxController {
  final RxBool rxIsAgreeToLicenseVideo = false.obs;
  final RxBool rxIsContentCopyrightCompliant = false.obs;
  final RxBool rxIsLicenseCopyrightErrorDisplay = false.obs;
  final RxnString rxImagePath = RxnString();
  final TextEditingController nameTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final RxBool rxIsNextButtonClickOn = false.obs;

  String? _name;
  String? _email;

  PostShortPackage? package;

  @override
  void onInit() {
    final arg = Get.arguments;
    if (arg != null) {
      package = arg;
      rxImagePath.value = package?.imagePreviewPath;
    }
    nameTextEditingController.addListener(nameTextChangeEvent);
    emailTextEditingController.addListener(emailTextChangeEvent);
  }

  void nameTextChangeEvent() {
    _name = nameTextEditingController.text;
    checkFormIsFill();
  }

  void emailTextChangeEvent() {
    _email = emailTextEditingController.text;
    checkFormIsFill();
  }

  void isAgreeToLicenseVideoChange(bool? value) {
    if (value == null) return;
    rxIsAgreeToLicenseVideo.value = value;
    rxIsLicenseCopyrightErrorDisplay.value = false;
    checkFormIsFill();
  }

  void isContentCopyrightCompliantChange(bool? value) {
    if (value == null) return;
    rxIsContentCopyrightCompliant.value = value;
    rxIsLicenseCopyrightErrorDisplay.value = false;
    checkFormIsFill();
  }

  void checkFormIsFill() {
    rxIsNextButtonClickOn.value = _name != null &&
        _name!.isNotEmpty &&
        _email != null &&
        _email!.isNotEmpty &&
        rxIsContentCopyrightCompliant.value == true &&
        rxIsAgreeToLicenseVideo.value == true;
  }

  void sentFormResult() {
    if (rxIsContentCopyrightCompliant.value == false ||
        rxIsAgreeToLicenseVideo.value == false) {
      rxIsLicenseCopyrightErrorDisplay.value = true;
    }

    if (_email == null || _email!.isEmpty) return;
    package?.email = _email;
    package?.name = _name;
    Get.toNamed(Routes.postShortVideoResultPage, arguments: package);
  }
}
