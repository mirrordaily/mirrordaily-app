import 'package:json_annotation/json_annotation.dart';

part 'news_marquee.g.dart';


@JsonSerializable()
class NewsMarquee extends Object {

  @JsonKey(name: 'outlink')
  String? outLink;

  @JsonKey(name: 'hotnews')
  HotNews? hotNews;

  NewsMarquee({this.outLink,this.hotNews});

  factory NewsMarquee.fromJson(Map<String, dynamic> srcJson) => _$NewsMarqueeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewsMarqueeToJson(this);

}


@JsonSerializable()
class HotNews extends Object {

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'title')
  String? title;

  HotNews(this.id,this.title,);

  factory HotNews.fromJson(Map<String, dynamic> srcJson) => _$HotNewsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotNewsToJson(this);

}


