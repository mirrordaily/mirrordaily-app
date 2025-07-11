// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectionResponse _$SectionResponseFromJson(Map<String, dynamic> json) =>
    SectionResponse(
      section: json['section'] == null
          ? null
          : SectionContent.fromJson(json['section'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SectionResponseToJson(SectionResponse instance) =>
    <String, dynamic>{
      'section': instance.section,
    };

SectionContent _$SectionContentFromJson(Map<String, dynamic> json) =>
    SectionContent(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ArticlePreview.fromJson(e as Map<String, dynamic>))
          .toList(),
      counts: json['counts'] == null
          ? null
          : SectionCounts.fromJson(json['counts'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SectionContentToJson(SectionContent instance) =>
    <String, dynamic>{
      'items': instance.items,
      'counts': instance.counts,
    };

SectionCounts _$SectionCountsFromJson(Map<String, dynamic> json) =>
    SectionCounts(
      posts: (json['posts'] as num?)?.toInt(),
      externals: (json['externals'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SectionCountsToJson(SectionCounts instance) =>
    <String, dynamic>{
      'posts': instance.posts,
      'externals': instance.externals,
    };
