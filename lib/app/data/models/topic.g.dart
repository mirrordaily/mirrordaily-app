// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topic _$TopicFromJson(Map<String, dynamic> json) => Topic(
      $enumDecodeNullable(_$TopicTypeEnumMap, json['type']) ?? TopicType.list,
      $enumDecodeNullable(_$TopicLeadingTypeEnumMap, json['leading']) ??
          TopicLeadingType.image,
      (json['posts'] as List<dynamic>?)
              ?.map((e) => Posts.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      (json['slideshow_images'] as List<dynamic>?)
              ?.map((e) => Resized.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      json['heroImage'] == null
          ? null
          : HeroImage.fromJson(json['heroImage'] as Map<String, dynamic>),
      json['heroVideo'] == null
          ? null
          : HeroVideo.fromJson(json['heroVideo'] as Map<String, dynamic>),
      (json['tags'] as List<dynamic>?)
              ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'type': _$TopicTypeEnumMap[instance.type],
      'leading': _$TopicLeadingTypeEnumMap[instance.leading],
      'tags': instance.tags,
      'posts': instance.posts,
      'slideshow_images': instance.slideshowImageList,
      'heroImage': instance.heroImage,
      'heroVideo': instance.heroVideo,
    };

const _$TopicTypeEnumMap = {
  TopicType.list: 'list',
  TopicType.group: 'group',
};

const _$TopicLeadingTypeEnumMap = {
  TopicLeadingType.video: 'video',
  TopicLeadingType.slideShow: 'slideshow',
  TopicLeadingType.image: 'image',
};

Posts _$PostsFromJson(Map<String, dynamic> json) => Posts(
      json['apiDataBrief'] as List<dynamic>? ?? [],
      json['title'] as String?,
      (json['tags'] as List<dynamic>?)
              ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      json['slug'] as String?,
      json['heroImage'] == null
          ? null
          : HeroImage.fromJson(json['heroImage'] as Map<String, dynamic>),
      json['subtitle'] as String?,
      json['id'] as String?,
    );

Map<String, dynamic> _$PostsToJson(Posts instance) => <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'slug': instance.slug,
      'tags': instance.tags,
      'id': instance.id,
      'heroImage': instance.heroImage,
      'apiDataBrief': instance.apiDataBrieList,
    };

HeroVideo _$HeroVideoFromJson(Map<String, dynamic> json) => HeroVideo(
      json['videoSrc'] as String?,
    );

Map<String, dynamic> _$HeroVideoToJson(HeroVideo instance) => <String, dynamic>{
      'videoSrc': instance.videoSrc,
    };

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      json['name'] as String,
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'name': instance.name,
    };
