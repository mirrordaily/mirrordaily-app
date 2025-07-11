import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/app/data/models/article_preview.dart';
import 'package:mirrordaily_app/app/data/models/editor_choices.dart';
import 'package:mirrordaily_app/app/data/models/external_article.dart';
import 'package:mirrordaily_app/app/data/models/live_stream_link.dart';
import 'package:mirrordaily_app/app/data/models/post_short_package.dart';
import 'package:mirrordaily_app/app/data/models/short_article.dart';
import 'package:mirrordaily_app/app/data/providers/base_gql_provider.dart';
import 'package:mirrordaily_app/core/values/gql_query.dart';

class ArticleGqlProvider extends BaseGQLProvider {
  Future<List<ArticlePreview>> getArticleListByTag(
      {required String name, int? take = 10, int? skip = 0}) async {
    final query = GQLQuery.getArticleListByTag;
    final result = await executeQuery(query,
        variables: {'name': name, 'take': take, 'skip': skip});
    if (result.hasException ||
        result.data == null ||
        result.data?['posts'] == null) {
      return [];
    }

    final postList = result.data!['posts'] as List<dynamic>;
    return postList.map((e) => ArticlePreview.fromJson(e)).toList();
  }

  Future<List<ArticlePreview>> getArticleListByWriter(
      {required String writerName, int? take = 10, int? skip = 0}) async {
    final query = GQLQuery.getArticleListByWriter;
    final result = await executeQuery(query,
        variables: {'name': writerName, 'take': take, 'skip': skip});
    if (result.hasException ||
        result.data == null ||
        result.data?['posts'] == null) {
      return [];
    }

    final postList = result.data!['posts'] as List<dynamic>;
    return postList.map((e) => ArticlePreview.fromJson(e)).toList();
  }

  Future<Article?> getArticleById({required String id}) async {
    final query = GQLQuery.getArticleById;
    final result = await executeQuery(query, variables: {'id': id});

    if (result.hasException ||
        result.data == null ||
        result.data?['post'] == null) {
      return null;
    }

    return Article.fromJson(result.data?['post']);
  }

  Future<ExternalArticle?> getExternalArticleById({required String id}) async {
    final query = GQLQuery.getExternalArticleById;
    final result = await executeQuery(query, variables: {'id': id});

    if (result.hasException ||
        result.data == null ||
        result.data?['external'] == null) {
      return null;
    }

    return ExternalArticle.fromJson(result.data?['external']);
  }


  Future<List<EditorChoice>> getEditorChoices() async {
    final query = GQLQuery.getEditorChoices;
    final result = await executeQuery(query);
    if (result.data == null || !result.data!.containsKey('editorChoices')) {
      return [];
    }
    final dataList = result.data!['editorChoices'] as List<dynamic>;
    return dataList.map((e) => EditorChoice.fromJson(e)).toList();
  }

  Future<LiveStreamLink?> getLiveStreamLink() async {
    final query = GQLQuery.getLiveStreamingLink;
    final result = await executeQuery(query);
    if (result.data == null || !result.data!.containsKey('events')) {
      return null;
    }

    final eventList = result.data!['events'] as List<dynamic>;
    if (eventList.isEmpty) return null;

    return LiveStreamLink.fromJson(eventList[0]);
  }

  Future<List<ArticlePreview>> getArticleBySectionSlugAndCategorySlug({
    String? slug,
    String? categorySlug,
    int? skip = 0,
    int? take = 10,
  }) async {
    if (slug == null) {
      return [];
    }

    final isAllCategory = categorySlug == null || categorySlug == 'all';
    final query = isAllCategory
        ? GQLQuery.getArticleBySectionOnlySlug
        : GQLQuery.getArticleBySectionSlug;

    final variables = {
      'slug': slug,
      'skip': skip,
      'take': take,
      if (!isAllCategory) 'category_slug': categorySlug,
    };

    final result = await graphQLProvider.query(query, variables: variables);

    if (result.hasException ||
        result.data == null ||
        result.data?['posts'] == null) {
      return [];
    }

    final postList = result.data!['posts'] as List<dynamic>;
    return postList.map((e) => ArticlePreview.fromJson(e)).toList();
  }

  Future<List<ShortArticle>> getShortArticleBySectionSlug(
      {required String slug}) async {
    final query = GQLQuery.getShortBySectionSlug;
    final result = await executeQuery(query, variables: {'slug': slug});
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

    final QueryResult result = await executeMutation(
        GQLQuery.createPreviewImageOfShorts,
        variables: variables);

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
    print('File Size:${multipartFile.length}');
    final Map<String, dynamic> variables = {
      'title': package.title,
      'photoId': photoId,
      'author': package.name,
      'authorEmail': package.email,
      'description': package.description,
      'file': multipartFile,
    };

    final QueryResult result =
        await executeMutation(GQLQuery.createShortVideo, variables: variables);

    if (result.hasException) {
      print('上傳失敗: ${result.exception.toString()}');
      return null;
    } else {
      return int.tryParse(result.data!['shorts']['id']);
    }
  }
}
