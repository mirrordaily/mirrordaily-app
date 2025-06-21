import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/enums/choice_type.dart';
import 'package:mirrordaily_app/app/data/enums/city.dart';
import 'package:mirrordaily_app/app/data/enums/news_page_type.dart';
import 'package:mirrordaily_app/app/data/enums/news_type.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/app/data/models/article_preview.dart';
import 'package:mirrordaily_app/app/data/models/editor_choices.dart';
import 'package:mirrordaily_app/app/data/models/live_stream_link.dart';
import 'package:mirrordaily_app/app/data/models/topic_preview.dart';
import 'package:mirrordaily_app/app/data/models/weather_response.dart';
import 'package:mirrordaily_app/app/data/providers/article_api_provider.dart';
import 'package:mirrordaily_app/app/data/providers/article_gql_provider.dart';
import 'package:mirrordaily_app/app/data/providers/section_gql_provider.dart';
import 'package:mirrordaily_app/app/data/providers/topic_gql_provider.dart';
import 'package:mirrordaily_app/app/data/providers/weather_api_provider.dart';
import 'package:mirrordaily_app/routes/routes.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NewsTabController extends GetxController {
  final ArticleGqlProvider articleGqlProvider = Get.find();
  final ArticleApiProvider articleApiProvider = Get.find();
  final TopicGqlProvider topicGqlProvider = Get.find();
  final SectionGqlProvider sectionGqlProvider = Get.find();

  final RxList<Section> rxSectionList = RxList();

  final Rx<ChoiceType> rxChoiceSelectType = ChoiceType.editor.obs;
  final Rx<NewsType> rxNewsType = NewsType.realTime.obs;
  final Rxn<LiveStreamLink> rxnLiveStreamLink = Rxn();
  final Rxn<YoutubePlayerController> rxnYoutubePlayerController = Rxn();
  final RxList<ArticlePreview> rxRenderArticleList = RxList();

  final Rx<NewsPageType> rxNewsPageType = NewsPageType.latest.obs;
  final Map<String, TopicPreview> topicPreviewMap = {};
  final WeatherApiProvider weatherApiProvider = Get.find();
  final Rxn<City> rxWeatherSelectCity = Rxn();
  final Rxn<WeatherData> rxSelectWeatherData = Rxn();
  final RxList<TopicPreview> rxTopicTabBarList = RxList();

  WeatherResponse? weatherResponse;

  @override
  void onInit() async {
    rxSectionList.value = await sectionGqlProvider.getSectionList();
    addCustomSections();
    rxRenderArticleList.value = await articleApiProvider.getLatestArticles();
    weatherResponse = await weatherApiProvider.getWeatherData();
    rxWeatherSelectCity.value = City.taipei;
    rxSelectWeatherData.value =
        weatherResponse?.cityWeatherMap[rxWeatherSelectCity.value];
    rxTopicTabBarList.value =
        await topicGqlProvider.getIsFeatureTopicPreviewList();
    configStreamLink();
    super.onInit();
  }

  void weatherCitySelectEvent(City? city) {
    if (city == null) return;
    rxWeatherSelectCity.value = city;
    rxSelectWeatherData.value = weatherResponse?.cityWeatherMap[city];
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
    rxnYoutubePlayerController.refresh();
  }

  void newsTypeClickEvent(NewsType type) async {
    rxNewsType.value = type;

    switch (type) {
      case NewsType.realTime: // TODO: Handle this case.
        rxRenderArticleList.value =
            await articleApiProvider.getLatestArticles();
        break;
      case NewsType.popular:
        rxRenderArticleList.value =
            await articleApiProvider.getPopularArticles();
        break;
    }
  }

  void initTopicBarList() {}

  void addCustomSections() async {


    final latestSection =
        Section(id: 'latest', name: '最新', slug: 'latest', color: '#1C7CED');

    final List<Section> otherSections = [
      Section(id: 'topic', name: '專題', slug: 'topic', color: '#F7FDFF'),
      Section(id: 'report', name: '我要爆料', slug: 'report', color: '#F7FDFF'),
    ];

    rxSectionList.removeWhere((s) => s.id == latestSection.id);
    rxSectionList.insert(0, latestSection);
    rxSectionList.addAll(otherSections);
  }

  void onSectionClickEvent(Section section) {
    if (section.slug == 'topic') {
      rxNewsPageType.value = NewsPageType.topic;
      return;
    }

    if (section.slug == 'report') {
      // TODO: 前往我要爆料頁面
      return;
    }

    if (section.slug == 'latest') {
      rxNewsPageType.value = NewsPageType.latest;
      return;
    }

    // 預設跳轉 section 頁面
    Get.toNamed(Routes.sectionPage, arguments: section);
  }

  void onTopicListItemClick(TopicPreview topic) {
    Get.toNamed(Routes.topicPage, arguments: topic);
  }

  void test() async {
    final result = await weatherApiProvider.getWeatherData();
    print('hello world');

    print(result?.cityWeatherMap.keys);
  }
}
