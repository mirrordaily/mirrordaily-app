import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/enums/choice_type.dart';
import 'package:mirrordaily_app/app/data/enums/news_page_type.dart';
import 'package:mirrordaily_app/app/data/enums/news_type.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/app/data/models/editor_choices.dart';
import 'package:mirrordaily_app/app/data/models/live_stream_link.dart';
import 'package:mirrordaily_app/app/data/providers/article_api_provider.dart';
import 'package:mirrordaily_app/app/data/providers/article_gql_provider.dart';
import 'package:mirrordaily_app/routes/routes.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NewsTabController extends GetxController {
  final ArticleGqlProvider articleGqlProvider = Get.find();
  final ArticleApiProvider articleApiProvider = Get.find();
  final RxList<Section> rxSectionList = RxList();
  final RxList<EditorChoice> rxEditorChoiceList = RxList();
  final Rx<ChoiceType> rxChoiceSelectType = ChoiceType.editor.obs;
  final Rx<NewsType> rxNewsType = NewsType.realTime.obs;
  final Rxn<LiveStreamLink> rxnLiveStreamLink = Rxn();
  final Rxn<YoutubePlayerController> rxnYoutubePlayerController = Rxn();
  final RxList<Article> rxRenderArticleList = RxList();

  final Rx<NewsPageType> rxNewsPageType = NewsPageType.latest.obs;

  @override
  void onInit() async {
    rxSectionList.value = await articleGqlProvider.getSectionList();
    addCustomSections();
    rxEditorChoiceList.value = await articleGqlProvider.getEditorChoices();
    // rxRenderArticleList.value = await articleApiProvider.getLatestArticles();
    configStreamLink();
    super.onInit();
  }

  void choiceTypeClickEvent(ChoiceType type) {
    rxChoiceSelectType.value = type;
  }

  void configStreamLink() async {
    rxnLiveStreamLink.value = await articleGqlProvider.getLiveStreamLink();
    if (rxnLiveStreamLink.value?.isWithinTimeRange() == false) {
      rxnYoutubePlayerController.value = null;
      return;
    }
    final link = rxnLiveStreamLink.value?.link;
    if (link == null) return;
    String? videoId;
    videoId = YoutubePlayer.convertUrlToId(link);
    if (videoId == null) return;
    rxnYoutubePlayerController.value = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(isLive: false, autoPlay: false));
  }

  void newsTypeClickEvent(NewsType type) {
    rxNewsType.value = type;
  }

  void addCustomSections() {
    // 定義三個要加入的 sections
    final latestSection =
        Section(id: 'latest', name: '最新', slug: 'latest', color: '#1C7CED');
    final List<Section> otherSections = [
      Section(id: 'topic', name: '專題', slug: 'topic', color: '#F7FDFF'),
      Section(id: 'report', name: '我要爆料', slug: 'report', color: '#F7FDFF'),
    ];

    // 移除舊的最新 (避免重複)
    rxSectionList.removeWhere((s) => s.id == latestSection.id);

    // 在第一個位置插入「最新」
    rxSectionList.insert(0, latestSection);
    rxSectionList.addAll(otherSections);
  }

  void test() async {}

  void onSectionClickEvent(Section section) {
    if (section.slug == 'latest') {
      rxNewsPageType.value = NewsPageType.latest;
      return;
    }
    if (section.slug == 'topic') {
      rxNewsPageType.value = NewsPageType.topic;
      return;
    }

    Get.toNamed(Routes.sectionPage, arguments: section);
  }
}
