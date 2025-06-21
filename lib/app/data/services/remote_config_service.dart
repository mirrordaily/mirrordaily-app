import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> initialize() async {
    try {
      // 設定 fetch 行為（可選）
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 30),
      ));

      // 抓最新設定
      await _remoteConfig.fetchAndActivate();
      print(_remoteConfig.getAll());
      debugPrint('✅ Remote Config initialized');
    } catch (e) {
      debugPrint('❌ Remote Config init failed: $e');
    }
  }

  String get minVersion => _remoteConfig.getString('min_version');

  bool get isMaintenance => _remoteConfig.getBool('is_maintenance');
}
