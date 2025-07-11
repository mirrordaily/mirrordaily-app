import 'package:json_annotation/json_annotation.dart';
import 'package:mirrordaily_app/app/data/models/article_preview.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse {
  @JsonKey(name: 'category')
  CategoryContent? category;

  CategoryResponse({this.category});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}

@JsonSerializable()
class CategoryContent {
  @JsonKey(name: 'items')
  List<ArticlePreview>? items;

  @JsonKey(name: 'counts')
  CategoryCounts? counts;

  CategoryContent({this.items, this.counts});

  factory CategoryContent.fromJson(Map<String, dynamic> json) =>
      _$CategoryContentFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryContentToJson(this);
}

@JsonSerializable()
class CategoryCounts {
  @JsonKey(name: 'posts')
  int? posts;

  @JsonKey(name: 'externals')
  int? externals;

  CategoryCounts({this.posts, this.externals});

  factory CategoryCounts.fromJson(Map<String, dynamic> json) =>
      _$CategoryCountsFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryCountsToJson(this);
} 