import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/topic.dart';
import 'package:mirrordaily_app/app/data/models/topic_preview.dart';
import 'package:mirrordaily_app/app/data/providers/base_gql_provider.dart';
import 'package:mirrordaily_app/app/data/providers/grapg_ql_provider.dart';
import 'package:mirrordaily_app/core/values/gql_query.dart';

class TopicGqlProvider extends BaseGQLProvider {
  Future<Topic?> getTopicBySlug({required String? slug}) async {
    final query = GQLQuery.getTopicBySlug;
    final result = await executeQuery(query, variables: {'slug': slug});

    if (result.data == null || !result.data!.containsKey('topic')) {
      return null;
    }
    return Topic.fromJson(result.data!['topic']);
  }

  Future<List<TopicPreview>> getTopicPreviewList() async {
    final query = GQLQuery.getTopicList;
    final result = await executeQuery(query);
    if (result.hasException || result.data == null) {
      return [];
    }
    final dataList = result.data!['topics'] as List<dynamic>;
    return dataList.map((e) => TopicPreview.fromJson(e)).toList();
  }

  Future<List<TopicPreview>> getIsFeatureTopicPreviewList() async {
    final query = GQLQuery.getFeaturesTopic;
    final result = await executeQuery(query);
    if (result.hasException || result.data == null) {
      return [];
    }
    final dataList = result.data!['topics'] as List<dynamic>;
    return dataList.map((e) => TopicPreview.fromJson(e)).toList();
  }
}
