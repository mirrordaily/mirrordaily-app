// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'external_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExternalArticle _$ExternalArticleFromJson(Map<String, dynamic> json) =>
    ExternalArticle(
      id: json['id'] as String?,
      title: json['title'] as String?,
      state: json['state'] as String?,
      publishedDateString: json['publishedDateString'] as String?,
      extendByline: json['extend_byline'] as String?,
      thumb: json['thumb'] as String?,
      thumbCaption: json['thumbCaption'] as String?,
      brief: json['brief'] as String?,
      content: json['content'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      sectionList: (json['sections'] as List<dynamic>?)
              ?.map((e) => Section.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      tagList: (json['tags'] as List<dynamic>?)
              ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      relatedArticleList: (json['relateds'] as List<dynamic>?)
              ?.map((e) => ArticlePreview.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ExternalArticleToJson(ExternalArticle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'state': instance.state,
      'publishedDateString': instance.publishedDateString,
      'extend_byline': instance.extendByline,
      'thumb': instance.thumb,
      'thumbCaption': instance.thumbCaption,
      'brief': instance.brief,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'sections': instance.sectionList,
      'tags': instance.tagList,
      'relateds': instance.relatedArticleList,
    };
