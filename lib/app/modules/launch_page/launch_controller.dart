import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/services/remote_config_service.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/routes/routes.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';

class LaunchController extends GetxController {
  final RemoteConfigService remoteConfigService = Get.find();

  @override
  void onInit() async {
    super.onInit();
    await remoteConfigService.initialize();
    final isMaintenance = remoteConfigService.isMaintenance;

    if (isMaintenance) {
      await Get.generalDialog(
        barrierDismissible: false,
        barrierLabel: 'Maintenance',
        barrierColor: Colors.black.withOpacity(0.3),
        // 半透明背景
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (_, __, ___) {
          return Material(
            color: Colors.transparent,
            child: Dialog(
              insetPadding: EdgeInsets.zero, // 移除預設邊距
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: const Color(0xFFF1E5F8),
              child: SizedBox(
                width: 279,
                height: 200,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      '目前 app 正在維修中，請稍後再試！',
                      textAlign: TextAlign.center,
                      style: Get.textTheme.titleMedium?.copyWith(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      checkVersionAndNavigate();
    }
  }

  Future<void> checkVersionAndNavigate() async {
    final minVersion = remoteConfigService.minVersion;

    final info = await PackageInfo.fromPlatform();
    final currentVersion = info.version;

    print('✅ Local version: $currentVersion');
    print('☁️ Min version: $minVersion');

    if (isVersionLower(currentVersion, minVersion)) {
      // 顯示強制更新彈窗（無法關閉）
      await Get.dialog(
        AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 48, vertical: 38),
          content: Text(
            '鏡報有新版本囉，立即更新取得最新資訊！',
            style: Get.textTheme.titleMedium
                ?.copyWith(color: CustomColorTheme.secondary20),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // TODO: 根據平台導向商店
                // Android: https://play.google.com/store/apps/details?id=com.xxx.xxx
                // iOS: https://apps.apple.com/app/id123456
                // 模擬跳轉
                Get.back(); // 可替換成 launch URL
              },
              child: const Text('前往更新'),
            ),
          ],
        ),
        barrierDismissible: false,
      );
    } else {
      await Future.delayed(const Duration(seconds: 1));
      Get.offAllNamed(Routes.homePage);
    }
  }

  bool isVersionLower(String current, String minimum) {
    List<int> parseVersion(String version) {
      return version
          .split('-')[0] // 去掉後綴（如 -dev）
          .split('.')     // 分割版本號
          .map((e) => int.tryParse(e) ?? 0) // 安全轉 int，轉換失敗當作 0
          .toList();
    }

    final currentParts = parseVersion(current);
    final minParts = parseVersion(minimum);

    for (int i = 0; i < minParts.length; i++) {
      final cur = i < currentParts.length ? currentParts[i] : 0;
      final min = i < minParts.length ? minParts[i] : 0;
      if (cur < min) return true;
      if (cur > min) return false;
    }
    return false;
  }
}
