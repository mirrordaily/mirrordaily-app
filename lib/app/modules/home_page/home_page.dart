import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/enums/short_section_type.dart';
import 'package:mirrordaily_app/app/data/providers/short_api_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(ImagePath.mirrorNesNetworkLogo),
        backgroundColor: CustomColorTheme.primary10,
        ///因搜尋功能尚未實作  先註解
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 20),
        //     child: InkWell(
        //       onTap: () {
        //         Get.toNamed(Routes.searchPage);
        //       },
        //       child: SvgPicture.asset(ImagePath.searchIcon),
        //     ),
        //   ),
        // ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Obx(() {
            final tabController = controller.rxnTabController.value;
            return TabBar(
              controller: tabController,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 10, // **設定 Indicator 的高度**
                  color: CustomColorTheme.primary90, // **Indicator 顏色**
                ),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: CustomColorTheme.primary90,
              unselectedLabelColor: CustomColorTheme.primary30,
              labelStyle: CustomTextStyle.subtitleSmall.copyWith(
                  color: CustomColorTheme.primary90,
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
