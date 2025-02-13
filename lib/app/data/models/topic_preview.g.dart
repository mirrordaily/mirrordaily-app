// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_preview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicPreview _$TopicPreviewFromJson(Map<String, dynamic> json) => TopicPreview(
      json['slug'] as String?,
      json['heroImage'] == null
          ? null
          : HeroImage.fromJson(json['heroImage'] as Map<String, dynamic>),
      json['name'] as String?,
    );

Map<String, dynamic> _$TopicPreviewToJson(TopicPreview instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'heroImage': instance.heroImage,
      'name': instance.name,
    };

HeroImage _$HeroImageFromJson(Map<String, dynamic> json) => HeroImage(
      json['topicKeywords'] as String?,
      json['copyRight'] as bool?,
      json['createdAt'] as String?,
      json['resized'] == null
          ? null
          : Resized.fromJson(json['resized'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HeroImageToJson(HeroImage instance) => <String, dynamic>{
      'topicKeywords': instance.topicKeywords,
      'copyRight': instance.copyRight,
      'createdAt': instance.createdAt,
      'resized': instance.resized,
    };

Resized _$ResizedFromJson(Map<String, dynamic> json) => Resized(
      json['original'] as String?,
      json['w480'] as String?,
      json['w800'] as String?,
      json['w1200'] as String?,
      json['w1600'] as String?,
      json['w2400'] as String?,
    );

Map<String, dynamic> _$ResizedToJson(Resized instance) => <String, dynamic>{
      'original': instance.original,
      'w480': instance.w480,
      'w800': instance.w800,
      'w1200': instance.w1200,
      'w1600': instance.w1600,
      'w2400': instance.w2400,
    };
