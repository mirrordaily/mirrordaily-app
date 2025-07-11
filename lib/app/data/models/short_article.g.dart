// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'short_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortArticle _$ShortArticleFromJson(Map<String, dynamic> json) => ShortArticle(
      id: json['id'] as String?,
      name: json['name'] as String?,
      videoSrc: json['videoSrc'] as String?,
      heroImage: json['heroImage'] == null
          ? null
          : HeroImage.fromJson(json['heroImage'] as Map<String, dynamic>),
      publishedDate: json['publishedDate'] as String?,
      videoSection: json['videoSection'] as String?,
      youtubeUrl: json['youtubeUrl'] as String?,
    );

Map<String, dynamic> _$ShortArticleToJson(ShortArticle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'youtubeUrl': instance.youtubeUrl,
      'videoSrc': instance.videoSrc,
      'publishedDate': instance.publishedDate,
      'videoSection': instance.videoSection,
      'heroImage': instance.heroImage,
    };
