// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_preview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticlePreview _$ArticlePreviewFromJson(Map<String, dynamic> json) =>
    ArticlePreview(
      json['slug'] as String?,
      json['title'] as String?,
      json['heroImage'] == null
          ? null
          : HeroImage.fromJson(json['heroImage'] as Map<String, dynamic>),
      json['createdAt'] as String?,
      (json['sections'] as List<dynamic>?)
              ?.map((e) => Section.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      json['id'] as String?,
      json['publishedDate'] as String?,
      (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      const PartnerConverter().fromJson(json['partner']),
      json['type'] as String?,
    );

Map<String, dynamic> _$ArticlePreviewToJson(ArticlePreview instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'title': instance.title,
      'sections': instance.sections,
      'heroImage': instance.heroImage,
      'createdAt': instance.createdAt,
      'id': instance.id,
      'publishedDate': instance.publishedDate,
      'type': instance.type,
      'partner': const PartnerConverter().toJson(instance.partner),
      'categories': instance.category,
    };

Categories _$CategoriesFromJson(Map<String, dynamic> json) => Categories(
      json['name'] as String?,
    );

Map<String, dynamic> _$CategoriesToJson(Categories instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

HeroImage _$HeroImageFromJson(Map<String, dynamic> json) => HeroImage(
      json['resized'] == null
          ? null
          : Resized.fromJson(json['resized'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HeroImageToJson(HeroImage instance) => <String, dynamic>{
      'resized': instance.resized,
    };

Resized _$ResizedFromJson(Map<String, dynamic> json) => Resized(
      json['w800'] as String?,
    );

Map<String, dynamic> _$ResizedToJson(Resized instance) => <String, dynamic>{
      'w800': instance.w800,
    };
