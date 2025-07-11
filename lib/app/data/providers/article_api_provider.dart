import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/helper/api_base_helper.dart';
import 'package:mirrordaily_app/app/data/models/article_preview.dart';
import 'package:mirrordaily_app/app/data/models/category_response.dart';
import 'package:mirrordaily_app/app/data/models/news_marquee.dart';
import 'package:mirrordaily_app/app/data/models/section_response.dart';
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

  Future<SectionResponse?> getArticleBySection(
      {required String sectionName, int? page = 1}) async {
    try {
      final url = '${Environment().config.sectionApiPath}latest_content_section_${sectionName}_$page.json';
      final result = await apiBaseHelper.get(url: url);
      
      if (result == null) return null;
      
      return SectionResponse.fromJson(result);
    } catch (e) {
      print('Error fetching section articles: $e');
      return null;
    }
  }

  Future<CategoryResponse?> getArticleByCategory(
      {required String category, int? page = 1}) async {
    try {
      final url = '${Environment().config.categoryApiPath}latest_content_category_${category}_$page.json';
      final result = await apiBaseHelper.get(url: url);
      
      if (result == null) return null;
      
      return CategoryResponse.fromJson(result);
    } catch (e) {
      print('Error fetching category articles: $e');
      return null;
    }
  }

  Future<List<ArticlePreview>> getMoreSectionArticlesByGql({
    required String sectionSlug,
    int skip = 0,
    int take = 10,
  }) async {
    const query = '''
      query (
        \$slug: String!, \$take: Int, \$skip: Int
      ) {
        posts(
          where: { sections: { some: { slug: { contains: \$slug } } } }
          take: \$take
          skip: \$skip
          orderBy: { publishedDate: desc }
        ) {
          id
          slug
          title
          publishedDate
          type
          heroImage {
            resized {
              original
              w480
              w800
              w1200
              w1600
              w2400
            }
          }
        }
      }
    ''';
    final result = await graphQLProvider.query(query, variables: {
      'slug': sectionSlug,
      'take': take,
      'skip': skip,
    });
    if (result.hasException || result.data == null || result.data?['posts'] == null) {
      return [];
    }
    final list = result.data?['posts'] as List<dynamic>;
    return list.map((e) => ArticlePreview.fromJson(e)).toList();
  }

  Future<List<ArticlePreview>> getMoreCategoryArticlesByGql({
    required String categorySlug,
    int skip = 0,
    int take = 10,
  }) async {
    const query = '''
      query (
        \$category_slug: String!, \$take: Int, \$skip: Int
      ) {
        posts(
          where: { categories: { some: { slug: { equals: \$category_slug } } } }
          take: \$take
          skip: \$skip
          orderBy: { publishedDate: desc }
        ) {
          id
          slug
          title
          publishedDate
          type
          heroImage {
            resized {
              original
              w480
              w800
              w1200
              w1600
              w2400
            }
          }
        }
      }
    ''';
    final result = await graphQLProvider.query(query, variables: {
      'category_slug': categorySlug,
      'take': take,
      'skip': skip,
    });
    if (result.hasException || result.data == null || result.data?['posts'] == null) {
      return [];
    }
    final list = result.data?['posts'] as List<dynamic>;
    return list.map((e) => ArticlePreview.fromJson(e)).toList();
  }
}
