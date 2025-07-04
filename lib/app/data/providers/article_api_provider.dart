import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/helper/api_base_helper.dart';
import 'package:mirrordaily_app/app/data/models/article_preview.dart';
import 'package:mirrordaily_app/app/data/models/news_marquee.dart';
import 'package:mirrordaily_app/app/data/providers/grapg_ql_provider.dart';
import 'package:mirrordaily_app/configs/environment.dart';

class ArticleApiProvider extends GetxService {
  final GraphQLProvider graphQLProvider = Get.find();
  final ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  Future<void> getLatestNews() async {}

  Future<List<NewsMarquee>> getNewsMarquee() async {
    final result =
        await apiBaseHelper.get(url: Environment().config.newsMarqueeApiPath);
    final resultList = result['hots'] as List<dynamic>;
    return resultList.map((e) => NewsMarquee.fromJson(e)).toList();
  }

  Future<List<ArticlePreview>> getLatestArticles() async {
    final result = await apiBaseHelper.get(
        url: Environment().config.latestArticlesApiPath);

    if (result == null) return [];

    final resultList = result['latest'] as List<dynamic>;
    return resultList.map((e) => ArticlePreview.fromJson(e)).toList();
  }

  Future<List<ArticlePreview>> getPopularArticles() async {
    final result = await apiBaseHelper.get(
        url: Environment().config.popularArticlesApiPath);

    if (result == null) return [];

    if (result is! List<dynamic>) return [];

    return result.map((e) => ArticlePreview.fromJson(e)).toList();
  }
}
