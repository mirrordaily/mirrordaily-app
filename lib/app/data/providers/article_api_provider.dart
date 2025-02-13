import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/helper/api_base_helper.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';

import 'package:mirrordaily_app/app/data/providers/grapg_ql_provider.dart';
import 'package:mirrordaily_app/core/values/gql_query.dart';

class ArticleApiProvider extends GetxService {
  final GraphQLProvider graphQLProvider = Get.find();
  final ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  Future<List<Section>> getSectionList() async {
    final query = GQLQuery.getSections;
    final result = await graphQLProvider.query(query);
    if (result.hasException || result.data == null) {
      return [];
    }
    final dataList = result.data!['sections'] as List<dynamic>;
    return dataList.map((e) => Section.fromJson(e)).toList();
  }

  Future<Article?> getArticleBySlug({required String slug}) async {
    final query = GQLQuery.getArticleBySlug;
    final result =
        await graphQLProvider.query(query, variables: {'slug': slug});

    if (result.hasException ||
        result.data == null ||
        result.data?['post'] == null) {
      return null;
    }

    return Article.fromJson(result.data?['post']);
  }

  Future<List<Article>> getNewsMarquee() async {
    final result = await apiBaseHelper.get(
        url:
            'https://storage.googleapis.com/statics-dev.mirrordaily.news/json/flash-news.json');
    print(result['posts']);
    final resultList = result['posts'] as List<dynamic>;
    return resultList.map((e) => Article.fromJson(e)).toList();
    // return Article.fromJson(result);
  }
}
