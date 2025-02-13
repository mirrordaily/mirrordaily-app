import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/article_page/article_binding.dart';
import 'package:mirrordaily_app/app/modules/article_page/article_page.dart';
import 'package:mirrordaily_app/app/modules/game_page/game_binding.dart';
import 'package:mirrordaily_app/app/modules/game_page/game_page.dart';
import 'package:mirrordaily_app/app/modules/home_page/home_binding.dart';
import 'package:mirrordaily_app/app/modules/home_page/home_page.dart';
import 'package:mirrordaily_app/app/modules/home_page/widgets/classfication_page/classification_binding.dart';
import 'package:mirrordaily_app/app/modules/home_page/widgets/classfication_page/classification_page.dart';
import 'package:mirrordaily_app/app/modules/home_page/widgets/news_page/news_binding.dart';
import 'package:mirrordaily_app/app/modules/home_page/widgets/news_page/news_page.dart';
import 'package:mirrordaily_app/app/modules/home_page/widgets/setting_page/setting_binding.dart';
import 'package:mirrordaily_app/app/modules/home_page/widgets/setting_page/setting_page.dart';
import 'package:mirrordaily_app/app/modules/home_page/widgets/short_page/short_video_binding.dart';
import 'package:mirrordaily_app/app/modules/home_page/widgets/short_page/short_video_page.dart';
import 'package:mirrordaily_app/app/modules/launch_page/launch_binding.dart';
import 'package:mirrordaily_app/app/modules/launch_page/launch_page.dart';
import 'package:mirrordaily_app/app/modules/post_short_video_page/post_short_binding.dart';
import 'package:mirrordaily_app/app/modules/post_short_video_page/post_short_page.dart';
import 'package:mirrordaily_app/app/modules/post_short_video_page/post_short_video_result_page/post_short_video_result_binding.dart';
import 'package:mirrordaily_app/app/modules/post_short_video_page/post_short_video_result_page/post_short_video_result_page.dart';
import 'package:mirrordaily_app/app/modules/post_short_video_page/post_short_video_user_check_page/post_short_video_user_check_binding.dart';
import 'package:mirrordaily_app/app/modules/post_short_video_page/post_short_video_user_check_page/post_short_video_user_check_page.dart';
import 'package:mirrordaily_app/app/modules/search_page/search_binding.dart';
import 'package:mirrordaily_app/app/modules/search_page/search_page.dart';
import 'package:mirrordaily_app/app/modules/section_page/section_page.dart';
import 'package:mirrordaily_app/app/modules/section_page/section_page_binding.dart';
import 'package:mirrordaily_app/app/modules/spill_the_tea_page/spill_the_tea_binding.dart';
import 'package:mirrordaily_app/app/modules/spill_the_tea_page/spill_the_tea_page.dart';
import 'package:mirrordaily_app/app/modules/topic_list_page/topic_list_binding.dart';
import 'package:mirrordaily_app/app/modules/topic_list_page/topic_list_page.dart';
import 'package:mirrordaily_app/routes/routes.dart';

class Pages {
  static final pages = [
    GetPage(
        name: Routes.launchPage,
        page: () => const LaunchPage(),
        binding: LaunchBinding()),
    GetPage(
        name: Routes.homePage,
        page: () => const HomePage(),
        binding: HomeBinding()),
    GetPage(
        name: Routes.searchPage,
        page: () => const SearchPage(),
        binding: SearchBinding()),
    GetPage(
        name: Routes.spillTheTeaPage,
        page: () => const SpillTheTeaPage(),
        binding: SpillTheTeaBinding()),
    GetPage(
        name: Routes.gamePage,
        page: () => const GamePage(),
        binding: GameBinding()),
    GetPage(
        name: Routes.articlePage,
        page: () => const ArticlePage(),
        binding: ArticleBinding()),
    GetPage(
        name: Routes.postShortVideoResultPage,
        page: () => const PostShortVideoResultPage(),
        binding: PostShortVideoResultBinding()),
    GetPage(
        name: Routes.postShortVideoPage,
        page: () => const PostShortVideoPage(),
        binding: PostShortVideoBinding()),
    GetPage(
        name: Routes.postShortVideoUserCheckPage,
        page: () => const PostShortVideoUserCheckPage(),
        binding: PostShortVideoUserCheckBinding()),
    GetPage(
        name: Routes.topicListPage,
        page: () => const TopicListPage(),
        binding: TopicListBinding()),
    GetPage(
        name: Routes.sectionPage,
        page: () => const SectionPage(),
        binding: SectionPageBinding())
  ];

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.newsPage:
        return GetPageRoute(
          settings: settings,
          page: () => const NewsPage(),
          binding: NewsBinding(),
        );
      case Routes.shortVideoPage:
        return GetPageRoute(
          settings: settings,
          page: () => const ShortVideoPage(),
          binding: ShortVideoBinding(),
        );
      case Routes.classificationPage:
        return GetPageRoute(
          settings: settings,
          page: () => const ClassificationPage(),
          binding: ClassificationBinding(),
        );
      case Routes.settingPage:
        return GetPageRoute(
          settings: settings,
          page: () => const SettingPage(),
          binding: SettingBinding(),
        );
    }

    return null;
  }
}
