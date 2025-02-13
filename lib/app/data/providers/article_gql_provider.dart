import 'package:get/get.dart';
import 'package:graphql/client.dart';

import 'package:http/http.dart' as http;
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/app/data/models/editor_choices.dart';
import 'package:mirrordaily_app/app/data/models/live_stream_link.dart';
import 'package:mirrordaily_app/app/data/models/post_short_package.dart';
import 'package:mirrordaily_app/app/data/models/short_article.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mirrordaily_app/app/data/providers/grapg_ql_provider.dart';

import 'package:mirrordaily_app/core/values/gql_query.dart';

class ArticleGqlProvider extends GetxService {
  final GraphQLProvider graphQLProvider = Get.find();

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

  Future<List<Category>> getCategoryBySectionSlug(
      {required String? slug}) async {
    final query = GQLQuery.getCategoriesBySectionSlug;
    final result =
        await graphQLProvider.query(query, variables: {'slug': slug});

    if (result.hasException ||
        result.data == null ||
        result.data?['categories'] == null) {
      return [];
    }
    final categoryList = result.data?['categories'] as List<dynamic>;

    return categoryList.map((e) => Category.fromJson(e)).toList();
  }

  Future<List<EditorChoice>> getEditorChoices() async {
    final query = GQLQuery.getEditorChoices;
    final result = await graphQLProvider.query(query);
    if (result.data == null || !result.data!.containsKey('editorChoices')) {
      return [];
    }
    final dataList = result.data!['editorChoices'] as List<dynamic>;
    return dataList.map((e) => EditorChoice.fromJson(e)).toList();
  }

  Future<LiveStreamLink?> getLiveStreamLink() async {
    final query = GQLQuery.getLiveStreamingLink;
    final result = await graphQLProvider.query(query);
    if (result.data == null || !result.data!.containsKey('events')) {
      return null;
    }

    final eventList = result.data!['events'] as List<dynamic>;
    if (eventList.isEmpty) return null;

    return LiveStreamLink.fromJson(eventList[0]);
  }

  Future<List<Article>> getArticleBySectionSlug({String? slug}) async {
    if (slug == null) {
      return [];
    }
    final query = GQLQuery.getArticleBySectionSlug;
    final result =
        await graphQLProvider.query(query, variables: {'slug': slug});
    if (result.hasException ||
        result.data == null ||
        result.data?['posts'] == null) {
      return [];
    }
    final postList = result.data!['posts'] as List<dynamic>;

    return postList.map((e) => Article.fromJson(e)).toList();
  }

  Future<List<ShortArticle>> getShortArticleBySectionSlug(
      {required String slug}) async {
    final query = GQLQuery.getShortBySectionSlug;
    final result =
        await graphQLProvider.query(query, variables: {'slug': slug});
    if (result.hasException ||
        result.data == null ||
        result.data?['videos'] == null) {
      return [];
    }
    final postList = result.data!['videos'] as List<dynamic>;

    return postList.map((e) => ShortArticle.fromJson(e)).toList();
  }

  Future<int?> uploadImageToGraphQL(http.MultipartFile multipartFile) async {
    final Map<String, dynamic> variables = {
      'name': multipartFile.filename,
      'file': multipartFile,
    };

    final QueryResult result = await graphQLProvider
        .mutate(GQLQuery.createPreviewImageOfShorts, variables: variables);

    if (result.hasException) {
      print('上傳失敗: ${result.exception.toString()}');
      return null;
    } else {
      return int.tryParse(result.data!['photo']['id']);
    }
  }

  Future<int?> uploadShortVideo(PostShortPackage package, photoId) async {
    final http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
      'file',
      package.videoXFile!.path,
      contentType: MediaType('video', 'mp4'),
    );

    final Map<String, dynamic> variables = {
      'title': package.title,
      'photoId': photoId,
      'author': package.name,
      'authorEmail': package.email,
      'description': package.description,
      'file': multipartFile,
    };

    final QueryResult result = await graphQLProvider
        .mutate(GQLQuery.createShortVideo, variables: variables);

    if (result.hasException) {
      print('上傳失敗: ${result.exception.toString()}');
      return null;
    } else {
      return int.tryParse(result.data!['shorts']['id']);
    }
  }
}
