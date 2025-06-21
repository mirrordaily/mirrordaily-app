import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/helper/api_base_helper.dart';
import 'package:mirrordaily_app/app/data/models/short_article.dart';
import 'package:mirrordaily_app/configs/environment.dart';

class ShortApiProvider extends GetConnect {
  final ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  Future<List<ShortArticle>> getRealTimeShort() async {
    final result = await apiBaseHelper.get(
        url: Environment().config.realTimeShortsApiPath);
    final resultList = result as List<dynamic>;
    return resultList.map((e) => ShortArticle.fromJson(e)).toList();
  }

  Future<List<ShortArticle>> getCreativityShort() async {
    final result = await apiBaseHelper.get(
        url: Environment().config.creativityShortApiPath);
    final resultList = result as List<dynamic>;
    return resultList.map((e) => ShortArticle.fromJson(e)).toList();
  }
}
