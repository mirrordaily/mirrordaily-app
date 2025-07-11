import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mirrordaily_app/configs/environment.dart';
import 'package:mirrordaily_app/mirror_daily_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Environment().initConfig(BuildFlavor.production);
  await Firebase.initializeApp();
  runApp(const MirrorDailyApp());
}
