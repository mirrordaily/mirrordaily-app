// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'short_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortArticle _$ShortArticleFromJson(Map<String, dynamic> json) => ShortArticle(
      id: json['id'] as String?,
      name: json['name'] as String?,
      videoSrc: json['videoSrc'] as String?,
      uploader: json['uploader'] as String?,
      uploaderEmail: json['uploaderEmail'] as String?,
    );

Map<String, dynamic> _$ShortArticleToJson(ShortArticle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'videoSrc': instance.videoSrc,
      'uploader': instance.uploader,
      'uploaderEmail': instance.uploaderEmail,
    };
