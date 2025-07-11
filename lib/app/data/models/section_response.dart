import 'package:json_annotation/json_annotation.dart';
import 'package:mirrordaily_app/app/data/models/article_preview.dart';

part 'section_response.g.dart';

@JsonSerializable()
class SectionResponse extends Object {
  @JsonKey(name: 'section')
  SectionContent? section;

  SectionResponse({this.section});

  factory SectionResponse.fromJson(Map<String, dynamic> srcJson) =>
      _$SectionResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SectionResponseToJson(this);
}

@JsonSerializable()
class SectionContent extends Object {
  @JsonKey(name: 'items')
  List<ArticlePreview>? items;

  @JsonKey(name: 'counts')
  SectionCounts? counts;

  SectionContent({this.items, this.counts});

  factory SectionContent.fromJson(Map<String, dynamic> srcJson) =>
      _$SectionContentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SectionContentToJson(this);
}

@JsonSerializable()
class SectionCounts extends Object {
  @JsonKey(name: 'posts')
  int? posts;

  @JsonKey(name: 'externals')
  int? externals;

  SectionCounts({this.posts, this.externals});

  factory SectionCounts.fromJson(Map<String, dynamic> srcJson) =>
      _$SectionCountsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SectionCountsToJson(this);
} 