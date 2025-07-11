import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/app/data/models/topic_preview.dart';
import 'package:mirrordaily_app/app/data/providers/header_api_provider.dart';

class HeaderDataProvider extends GetxService {
  final HeaderApiProvider headerApiProvider = Get.find();
  List<Section> sectionList = [];
  List<TopicPreview> topicList = [];
  final RxList<Section> rxSectionList = RxList();
  final RxList<TopicPreview> rxTopicTabBarList = RxList();

  Future<void> fetchHeaderData() async {
    final result = await headerApiProvider.getHeaderJson();
    for (var item in result) {
      if (item is Map<String, dynamic>) {
        if (item['type'] == 'Section') {
          sectionList.add(Section.fromJson(item));
        } else if (item['type'] == 'Topic') {
          topicList.add(TopicPreview.fromJson(item));
        }
      }
    }

  }

  @override
  void onReady() async {
    fetchHeaderData();
  }
}
