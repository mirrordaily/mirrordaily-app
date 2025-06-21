import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mirrordaily_app/configs/environment.dart';
import 'package:mirrordaily_app/firebase_flavor_config.dart';
import 'package:mirrordaily_app/mirror_daily_app.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'firebase_options_dev.dart'; // 檔名應該是 _dev.dart（不是.dev.dart）

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  Environment().initConfig(BuildFlavor.development);
  await Firebase.initializeApp();

  runApp(const MirrorDailyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
