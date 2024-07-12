import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mirrordaily_app/configs/environment.dart';
import 'package:mirrordaily_app/mirror_daily_app.dart';

void main() {
  ///Firebase setting
  ///環境設定 dev
  HttpOverrides.global = MyHttpOverrides();
  Environment().initConfig(BuildFlavor.development);
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
