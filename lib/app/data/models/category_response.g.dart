// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse(
      category: json['category'] == null
          ? null
          : CategoryContent.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'category': instance.category,
    };

CategoryContent _$CategoryContentFromJson(Map<String, dynamic> json) =>
    CategoryContent(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ArticlePreview.fromJson(e as Map<String, dynamic>))
          .toList(),
      counts: json['counts'] == null
          ? null
          : CategoryCounts.fromJson(json['counts'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryContentToJson(CategoryContent instance) =>
    <String, dynamic>{
      'items': instance.items,
      'counts': instance.counts,
    };

CategoryCounts _$CategoryCountsFromJson(Map<String, dynamic> json) =>
    CategoryCounts(
      posts: (json['posts'] as num?)?.toInt(),
      externals: (json['externals'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CategoryCountsToJson(CategoryCounts instance) =>
    <String, dynamic>{
      'posts': instance.posts,
      'externals': instance.externals,
    };
