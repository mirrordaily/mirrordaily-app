import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:mirrordaily_app/core/values/lottie_path.dart';
import 'loading_controller.dart';

class LoadingWidget {
  static final LoadingController _loadingController =
      Get.put(LoadingController());
  static OverlayEntry? _overlayEntry;

  static Future<void> show(Function asyncFunction) async {
    _showOverlay();

    try {
      await asyncFunction();
    } finally {
      _hideOverlay();
    }
  }
  static void _showOverlay() {
    if (_overlayEntry != null) return;
    _overlayEntry = OverlayEntry(
      builder: (context) => Obx(() {
        final isLoading = _loadingController.isLoading.value;
        return isLoading
            ? Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.black.withOpacity(0),
                    ),
                  ),
                  Container(
                    color: Colors.black54,
                    child: Center(
                      child: Lottie.asset(LottiePath.loading),
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink();
      }),
    );

    _loadingController.showLoading();

    final overlayState =
        Get.overlayContext?.findAncestorStateOfType<OverlayState>();
    if (overlayState != null) {
      overlayState.insert(_overlayEntry!);
    }
  }

  static void _hideOverlay() {
    _loadingController.hideLoading();
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
