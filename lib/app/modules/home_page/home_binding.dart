import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/providers/short_api_provider.dart';
import 'package:mirrordaily_app/app/data/providers/weather_api_provider.dart';

import 'package:mirrordaily_app/app/modules/home_page/home_controller.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/news_page/news_tab_controller.dart';
import 'package:mirrordaily_app/app/modules/home_page/tab_pages/short_page/short_tab_controller.dart';

import 'tab_pages/news_page/widget/tab_content/topic_tab_content/topic_tab_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {

    Get.put(WeatherApiProvider());
    Get.put(ShortApiProvider());
    Get.put(HomeController());
    Get.put(NewsTabController());
    Get.put(ShortTabController());
    Get.put(TopicTabController());
  }
}
