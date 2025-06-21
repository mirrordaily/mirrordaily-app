import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/enums/topic_type.dart';
import 'package:mirrordaily_app/app/data/models/topic.dart';
import 'package:mirrordaily_app/app/data/models/topic_preview.dart';
import 'package:mirrordaily_app/app/data/providers/article_gql_provider.dart';
import 'package:mirrordaily_app/app/data/providers/topic_gql_provider.dart';

class TopicPageController extends GetxController {
  final Rxn<TopicPreview> rxnTopicPreview = Rxn();
  final Rxn<Topic> rxnTopic = Rxn();
  final ArticleGqlProvider articleGqlProvider = Get.find();
  final RxMap<String, List<Posts>> rxMapPostGroup = RxMap();
  final TopicGqlProvider topicGqlProvider = Get.find();

  @override
  void onInit() async {
    super.onInit();
    rxnTopicPreview.value = Get.arguments;
    rxnTopic.value = await topicGqlProvider.getTopicBySlug(
        slug: rxnTopicPreview.value?.slug);
    if (rxnTopic.value?.type == TopicType.group) {
      initGroupPost();
    }
  }

  void initGroupPost() {
    final tags = rxnTopic.value?.tags;
    if (tags != null && tags.isNotEmpty) {
      for (var tag in tags) {
        rxMapPostGroup[tag.name] = [];
      }
    }

    final postList = rxnTopic.value?.posts;
    if (postList != null && postList.isNotEmpty) {
      for (var post in postList) {
        final postTags = rxnTopic.value?.tags;
        if (postTags != null && postTags.isNotEmpty) {
          for (var postTag in postTags) {
            if (rxMapPostGroup.containsKey(postTag.name)) {
              rxMapPostGroup[postTag.name]!.add(post);
            }
          }
        }
      }
    }
  }
}
