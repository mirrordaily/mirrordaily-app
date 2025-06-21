import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/topic_preview.dart';
import 'package:mirrordaily_app/app/data/providers/article_gql_provider.dart';
import 'package:mirrordaily_app/app/data/providers/topic_gql_provider.dart';
import 'package:mirrordaily_app/routes/routes.dart';

class TopicTabController extends GetxController {
  final RxList<TopicPreview> rxTopicPreviewList = RxList();
  final TopicGqlProvider topicGqlProvider = Get.find();

  @override
  void onInit() async {
    super.onInit();
    final allTopics = await topicGqlProvider.getTopicPreviewList();
    rxTopicPreviewList.value =
        allTopics.where((e) => e.idPostList!.isNotEmpty).toList();

  }

  void onTopicPreviewItemClick(TopicPreview? item) {
    Get.toNamed(Routes.topicPage, arguments: item);
  }
}
