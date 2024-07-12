// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      id: json['id'] as String?,
      slug: json['slug'] as String?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      state: json['state'] as String?,
      publishedDate: json['publishedDate'] as String?,
      publishedDateString: json['publishedDateString'] as String?,
      updateTimeStamp: json['updateTimeStamp'] as bool?,
      extendByline: json['extend_byline'] as String?,
      heroCaption: json['heroCaption'] as String?,
      style: json['style'] as String?,
      isMember: json['isMember'] as bool?,
      ogDescription: json['og_description'] as String?,
      isFeatured: json['isFeatured'] as bool?,
      isAdult: json['isAdult'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      writers: (json['writers'] as List<dynamic>?)
          ?.map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList(),
      photographers: (json['photographers'] as List<dynamic>?)
          ?.map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList(),
      cameraMan: (json['camera_man'] as List<dynamic>?)
          ?.map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList(),
      designers: (json['designers'] as List<dynamic>?)
          ?.map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList(),
      engineers: (json['engineers'] as List<dynamic>?)
          ?.map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList(),
      vocals: (json['vocals'] as List<dynamic>?)
          ?.map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList(),
      heroImage: json['heroImage'] == null
          ? null
          : HeroImage.fromJson(json['heroImage'] as Map<String, dynamic>),
      relateds: (json['relateds'] as List<dynamic>?)
          ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      ogTitle: json['og_title'] as String?,
      categoryList: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      sectionList: (json['sections'] as List<dynamic>?)
          ?.map((e) => Section.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..apiDataBrief = (json['apiDataBrief'] as List<dynamic>?)
          ?.map((e) => ApiData.fromJson(e as Map<String, dynamic>))
          .toList()
      ..apiData = (json['apiData'] as List<dynamic>?)
          ?.map((e) => ApiData.fromJson(e as Map<String, dynamic>))
          .toList()
      ..trimmedApiData = (json['trimmedApiData'] as List<dynamic>?)
          ?.map((e) => ApiData.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'state': instance.state,
      'publishedDate': instance.publishedDate,
      'publishedDateString': instance.publishedDateString,
      'updateTimeStamp': instance.updateTimeStamp,
      'extend_byline': instance.extendByline,
      'heroCaption': instance.heroCaption,
      'style': instance.style,
      'isMember': instance.isMember,
      'og_description': instance.ogDescription,
      'isFeatured': instance.isFeatured,
      'isAdult': instance.isAdult,
      'apiDataBrief': instance.apiDataBrief,
      'apiData': instance.apiData,
      'trimmedApiData': instance.trimmedApiData,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'writers': instance.writers,
      'photographers': instance.photographers,
      'camera_man': instance.cameraMan,
      'designers': instance.designers,
      'engineers': instance.engineers,
      'vocals': instance.vocals,
      'heroImage': instance.heroImage,
      'relateds': instance.relateds,
      'tags': instance.tags,
      'og_title': instance.ogTitle,
      'sections': instance.sectionList,
      'categories': instance.categoryList,
    };

Styles _$StylesFromJson(Map<String, dynamic> json) => Styles();

Map<String, dynamic> _$StylesToJson(Styles instance) => <String, dynamic>{};

ApiData _$ApiDataFromJson(Map<String, dynamic> json) => ApiData(
      id: json['id'] as String?,
      type: $enumDecodeNullable(_$ApiDataTypeEnumMap, json['type']) ??
          ApiDataType.unKnow,
      styles: json['styles'] == null
          ? null
          : Styles.fromJson(json['styles'] as Map<String, dynamic>),
      content: json['content'] as List<dynamic>?,
      alignment: json['alignment'] as String?,
    )
      ..contentData = json['contentData'] as String?
      ..contentList = json['contentList'] as List<dynamic>?
      ..contentMap = json['contentMap'] as Map<String, dynamic>?;

Map<String, dynamic> _$ApiDataToJson(ApiData instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$ApiDataTypeEnumMap[instance.type],
      'styles': instance.styles,
      'content': instance.content,
      'alignment': instance.alignment,
      'contentData': instance.contentData,
      'contentList': instance.contentList,
      'contentMap': instance.contentMap,
    };

const _$ApiDataTypeEnumMap = {
  ApiDataType.unStyled: 'unstyled',
  ApiDataType.headerTwo: 'header-two',
  ApiDataType.headerThree: 'header-three',
  ApiDataType.blockQuote: 'blockquote',
  ApiDataType.unorderedListItem: 'unordered-list-item',
  ApiDataType.orderedListItem: 'ordered-list-item',
  ApiDataType.divider: 'divider',
  ApiDataType.videoV2: 'video-v2',
  ApiDataType.audioV2: 'audio-v2',
  ApiDataType.image: 'image',
  ApiDataType.slideShowV2: 'slideshow-v2',
  ApiDataType.infoBox: 'infobox',
  ApiDataType.youtube: 'youtube',
  ApiDataType.table: 'table',
  ApiDataType.embeddedCode: 'embeddedcode',
  ApiDataType.unKnow: null,
};

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Resized _$ResizedFromJson(Map<String, dynamic> json) => Resized(
      original: json['original'] as String?,
      w480: json['w480'] as String?,
      w800: json['w800'] as String?,
      w1200: json['w1200'] as String?,
      w1600: json['w1600'] as String?,
      w2400: json['w2400'] as String?,
    );

Map<String, dynamic> _$ResizedToJson(Resized instance) => <String, dynamic>{
      'original': instance.original,
      'w480': instance.w480,
      'w800': instance.w800,
      'w1200': instance.w1200,
      'w1600': instance.w1600,
      'w2400': instance.w2400,
    };

HeroImage _$HeroImageFromJson(Map<String, dynamic> json) => HeroImage(
      id: json['id'] as String?,
      name: json['name'] as String?,
      waterMark: json['waterMark'] as bool?,
      topicKeywords: json['topicKeywords'] as String?,
      resized: json['resized'] == null
          ? null
          : Resized.fromJson(json['resized'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HeroImageToJson(HeroImage instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'waterMark': instance.waterMark,
      'topicKeywords': instance.topicKeywords,
      'resized': instance.resized,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
    };

Section _$SectionFromJson(Map<String, dynamic> json) => Section(
      id: json['id'] as String?,
      name: json['name'] as String?,
      color: json['color'] as String?,
      slug: json['slug'] as String?,
    );

Map<String, dynamic> _$SectionToJson(Section instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'slug': instance.slug,
    };

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      id: json['id'] as String?,
      slug: json['slug'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'name': instance.name,
    };
