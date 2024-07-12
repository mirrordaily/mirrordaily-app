import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/home_page/home_controller.dart';
import 'package:mirrordaily_app/routes/pages.dart';
import 'package:mirrordaily_app/routes/routes.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Navigator(
        key: Get.nestedKey(Routes.navigationBarKey),
        initialRoute: Routes.newsPage,
        onGenerateRoute: Pages.onGenerateRoute,
      ),
      bottomNavigationBar: Obx(() {
        final currentIndex = controller.rxCurrentBottomIndex.value;
        return BottomNavigationBar(
          currentIndex: currentIndex,
          backgroundColor: Colors.black,
          onTap: (index) => controller.onBottomNavigationItemClick(index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home_filled),
              label: '新聞',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_chat_outlined),
              activeIcon: Icon(Icons.video_chat),
              label: '短影音',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              activeIcon: Icon(Icons.video_chat),
              label: '分類',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_chat_outlined),
              activeIcon: Icon(Icons.video_chat),
              label: '設定',
            ),
          ],
        );
      }),
    );
  }
}
