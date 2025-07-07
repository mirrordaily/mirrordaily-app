import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mirrordaily_app/app/data/enums/apidata_type.dart';
import 'package:mirrordaily_app/app/data/models/article_preview.dart';

part 'article.g.dart';

@JsonSerializable()
class Article extends Object {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'slug')
  String? slug;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'subtitle')
  String? subtitle;

  @JsonKey(name: 'state')
  String? state;

  @JsonKey(name: 'publishedDate')
  String? publishedDate;

  @JsonKey(name: 'publishedDateString')
  String? publishedDateString;

  @JsonKey(name: 'updateTimeStamp')
  bool? updateTimeStamp;

  @JsonKey(name: 'extend_byline')
  String? extendByline;

  @JsonKey(name: 'heroCaption')
  String? heroCaption;

  @JsonKey(name: 'style')
  String? style;

  @JsonKey(name: 'isMember')
  bool? isMember;

  @JsonKey(name: 'og_description')
  String? ogDescription;

  @JsonKey(name: 'isFeatured')
  bool? isFeatured;

  @JsonKey(name: 'isAdult')
  bool? isAdult;

  @JsonKey(name: 'apiDataBrief')
  List<ApiData>? apiDataBrief;

  @JsonKey(name: 'apiData')
  List<ApiData>? apiData;

  @JsonKey(name: 'trimmedApiData')
  List<ApiData>? trimmedApiData;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  @JsonKey(name: 'writers')
  List<Person>? writers;

  @JsonKey(name: 'photographers')
  List<Person>? photographers;

  @JsonKey(name: 'camera_man')
  List<Person>? cameraMan;

  @JsonKey(name: 'designers')
  List<Person>? designers;

  @JsonKey(name: 'engineers')
  List<Person>? engineers;

  @JsonKey(name: 'vocals')
  List<Person>? vocals;

  @JsonKey(name: 'heroImage')
  HeroImage? heroImage;

  @JsonKey(name: 'relateds')
  List<ArticlePreview>? relateds;

  @JsonKey(name: 'tags')
  List<Tag>? tags;

  @JsonKey(name: 'tags_algo')
  List<Tag>? algoTags;

  @JsonKey(name: 'og_title')
  String? ogTitle;

  @JsonKey(name: 'sections')
  List<Section>? sectionList;

  @JsonKey(name: 'categories')
  List<Category>? categoryList;

  @JsonKey(name: 'manualOrderOfRelateds')
  List<ArticlePreview>? relateArticleList;

  @JsonKey(name: 'Warnings')
  List<Map<String, dynamic>>? warningList;

  Article(
      {this.id,
      this.slug,
      this.title,
      this.subtitle,
      this.state,
      this.publishedDate,
      this.publishedDateString,
      this.updateTimeStamp,
      this.extendByline,
      this.heroCaption,
      this.style,
      this.isMember,
      this.ogDescription,
      this.isFeatured,
      this.isAdult,
      this.createdAt,
      this.updatedAt,
      this.writers,
      this.photographers,
      this.cameraMan,
      this.designers,
      this.engineers,
      this.vocals,
      this.heroImage,
      this.relateds,
      this.tags,
      this.ogTitle,
      this.categoryList,
      this.sectionList,
      this.algoTags,
      this.warningList,
      this.relateArticleList});

  factory Article.fromJson(Map<String, dynamic> srcJson) {
    return _$ArticleFromJson(srcJson);
  }

  List<Tag> get combinedTags {
    return [
      ...(tags ?? []),
      ...(algoTags ?? []),
    ];
  }

  List<ArticlePreview> get orderedRelateds {
    if (relateds == null || relateArticleList == null) return relateds ?? [];
    final manualOrderIds =
        relateArticleList!.map((e) => e.id).whereType<String>().toList();
    final relatedMap = {for (var r in relateds!) r.id: r};
    final ordered = <ArticlePreview>[];

    // 加入 manual order 中有的
    for (var id in manualOrderIds) {
      if (relatedMap.containsKey(id)) {
        ordered.add(relatedMap[id]!);
      }
    }

    // 加入其他未在 manual order 中的
    for (var r in relateds!) {
      if (!manualOrderIds.contains(r.id)) {
        ordered.add(r);
      }
    }

    return ordered;
  }

  bool get isApiDataBriefBlank {
    if (apiDataBrief == null || apiDataBrief!.isEmpty) return true;

    return apiDataBrief!.every((data) {
      final content = data.content;
      return content == null ||
          content.isEmpty ||
          content.every((element) =>
              (element is String && element.trim().isEmpty) || element == null);
    });
  }

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

@JsonSerializable()
class Styles extends Object {
  Styles();

  factory Styles.fromJson(Map<String, dynamic> srcJson) =>
      _$StylesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$StylesToJson(this);
}

@JsonSerializable()
class ApiData extends Object {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'type', defaultValue: ApiDataType.unKnow)
  ApiDataType? type;

  @JsonKey(name: 'styles')
  Styles? styles;

  @JsonKey(name: 'content')
  List<dynamic>? content;

  @JsonKey(name: 'alignment')
  String? alignment;

  String? contentData;
  List<dynamic>? contentList;
  Map<String, dynamic>? contentMap;

  ApiData({this.id, this.type, this.styles, this.content, this.alignment});

  factory ApiData.fromJson(Map<String, dynamic> srcJson) {
    final apiDataObj = _$ApiDataFromJson(srcJson);

    /// draft js data處理
    switch (apiDataObj.type) {
      case ApiDataType.headerThree:
      case ApiDataType.headerTwo:
      case ApiDataType.unStyled:
      case ApiDataType.article:
      case ApiDataType.blockQuote:
      case ApiDataType.divider:
      case ApiDataType.section:
        apiDataObj.contentData = apiDataObj.content?[0];
        break;
      case ApiDataType.unorderedListItem:
      case ApiDataType.orderedListItem:
        apiDataObj.contentList = apiDataObj.content?[0];
        break;
      case ApiDataType.table:
        final rowList = apiDataObj.content ?? [];
        final result = rowList.map((row) {
          final columList = row as List<dynamic>;
          return columList.map((colum) => colum['html'].toString()).toList();
        }).toList();
        apiDataObj.contentList = result;
        break;

      case ApiDataType.infoBox:
      case ApiDataType.slideShowV2:
      case ApiDataType.youtube:
      case ApiDataType.audioV2:
      case ApiDataType.videoV2:
      case ApiDataType.image:
      case ApiDataType.embeddedCode:
        apiDataObj.contentMap = apiDataObj.content?[0];
        break;
      case ApiDataType.unKnow:
      case null:
      default:
      // TODO: Handle this case.
    }

    return apiDataObj;
  }

  Map<String, dynamic> toJson() => _$ApiDataToJson(this);
}

@JsonSerializable()
class Person extends Object {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'name')
  String? name;

  Person({this.id, this.name});

  factory Person.fromJson(Map<String, dynamic> srcJson) =>
      _$PersonFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}

@JsonSerializable()
class Resized extends Object {
  @JsonKey(name: 'original')
  String? original;

  @JsonKey(name: 'w480')
  String? w480;

  @JsonKey(name: 'w800')
  String? w800;

  @JsonKey(name: 'w1200')
  String? w1200;

  @JsonKey(name: 'w1600')
  String? w1600;

  @JsonKey(name: 'w2400')
  String? w2400;

  Resized(
      {this.original,
      this.w480,
      this.w800,
      this.w1200,
      this.w1600,
      this.w2400});

  factory Resized.fromJson(Map<String, dynamic> srcJson) =>
      _$ResizedFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResizedToJson(this);
}

@JsonSerializable()
class HeroImage extends Object {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'waterMark')
  bool? waterMark;

  @JsonKey(name: 'topicKeywords')
  String? topicKeywords;

  @JsonKey(name: 'resized')
  Resized? resized;

  HeroImage(
      {this.id, this.name, this.waterMark, this.topicKeywords, this.resized});

  factory HeroImage.fromJson(Map<String, dynamic> srcJson) =>
      _$HeroImageFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeroImageToJson(this);
}

@JsonSerializable()
class Category extends Object {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'slug')
  String? slug;

  Category({this.id, this.name, this.slug});

  factory Category.fromJson(Map<String, dynamic> srcJson) =>
      _$CategoryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Section extends Object {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'color')
  String? color;

  @JsonKey(name: 'slug')
  String? slug;
  @JsonKey(name: 'categories', defaultValue: [])
  List<Category>? categories;

  Section({this.id, this.name, this.color, this.slug, this.categories});

  Color get renderColor {
    String hexColor = color?.toUpperCase().replaceAll("#", "") ?? 'FFFFFF';
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor"; // Add alpha value if not provided
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  factory Section.fromJson(Map<String, dynamic> srcJson) =>
      _$SectionFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SectionToJson(this);
}

@JsonSerializable()
class Tag extends Object {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'slug')
  String? slug;

  @JsonKey(name: 'name')
  String? name;

  Tag({this.id, this.slug, this.name});

  factory Tag.fromJson(Map<String, dynamic> srcJson) => _$TagFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}
