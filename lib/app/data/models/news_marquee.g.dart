// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_marquee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsMarquee _$NewsMarqueeFromJson(Map<String, dynamic> json) => NewsMarquee(
      outLink: json['outlink'] as String?,
      hotNews: json['hotnews'] == null
          ? null
          : HotNews.fromJson(json['hotnews'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NewsMarqueeToJson(NewsMarquee instance) =>
    <String, dynamic>{
      'outlink': instance.outLink,
      'hotnews': instance.hotNews,
    };

HotNews _$HotNewsFromJson(Map<String, dynamic> json) => HotNews(
      json['id'] as String?,
      json['title'] as String?,
    );

Map<String, dynamic> _$HotNewsToJson(HotNews instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
