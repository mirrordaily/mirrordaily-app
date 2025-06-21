import 'package:json_annotation/json_annotation.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/app/data/models/article_preview.dart';

part 'external_article.g.dart';

@JsonSerializable()
class ExternalArticle extends Object {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'state')
  String? state;

  @JsonKey(name: 'publishedDateString')
  String? publishedDateString;

  @JsonKey(name: 'extend_byline')
  String? extendByline;

  @JsonKey(name: 'thumb')
  String? thumb;

  @JsonKey(name: 'thumbCaption')
  String? thumbCaption;

  @JsonKey(name: 'brief')
  String? brief;

  @JsonKey(name: 'content')
  String? content;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  @JsonKey(name: 'sections', defaultValue: [])
  List<Section>? sectionList;

  @JsonKey(name: 'tags', defaultValue: [])
  List<Tag>? tagList;

  @JsonKey(name: 'relateds', defaultValue: [])
  List<ArticlePreview>? relatedArticleList;

  ExternalArticle(
      {this.id,
      this.title,
      this.state,
      this.publishedDateString,
      this.extendByline,
      this.thumb,
      this.thumbCaption,
      this.brief,
      this.content,
      this.createdAt,
      this.updatedAt,
      this.sectionList,
      this.tagList,
      this.relatedArticleList});

  factory ExternalArticle.fromJson(Map<String, dynamic> srcJson) =>
      _$ExternalArticleFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ExternalArticleToJson(this);
}
