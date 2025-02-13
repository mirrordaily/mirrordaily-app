import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/home_page/home_controller.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/news_page/news_tab_page.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/short_page/short_tab_page.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/theme/custom_text_style.dart';
import 'package:mirrordaily_app/core/values/image_path.dart';
import 'package:mirrordaily_app/routes/pages.dart';
import 'package:mirrordaily_app/routes/routes.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  Widget _buildTabItem(String title, bool isSelect) {
    return Tab(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelect ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(ImagePath.mirrorNesNetworkLogo),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.search,
                size: 20,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Obx(() {
            final tabController = controller.rxnTabController.value;
            return TabBar(
              controller: tabController,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 10, // **設定 Indicator 的高度**
                  color: Colors.black, // **Indicator 顏色**
                ),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.green,
              labelColor: CustomColorTheme.secondary20,
              unselectedLabelColor: Colors.grey,
              labelStyle: CustomTextStyle.subtitleSmall.copyWith(
                  color: CustomColorTheme.secondary20,
                  fontWeight: FontWeight.w700),
              tabs: const [
                Tab(text: "新聞"),
                Tab(text: "短影音"),
              ],
            );
          }),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: controller.rxnTabController.value,
              children: const [
                NewsTabPage(),
                ShortTabPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
