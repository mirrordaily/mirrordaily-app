import 'package:flutter/material.dart';
import 'package:mirrordaily_app/configs/environment.dart';
import 'package:mirrordaily_app/mirror_daily_app.dart';

void main() {
  ///Firebase setting
  ///環境設定 prod
  Environment().initConfig(BuildFlavor.production);
  runApp(const MirrorDailyApp());
}
