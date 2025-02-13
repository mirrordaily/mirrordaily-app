import 'package:json_annotation/json_annotation.dart';

part 'topic_preview.g.dart';

@JsonSerializable()
class TopicPreview extends Object {
  @JsonKey(name: 'slug')
  String? slug;

  @JsonKey(name: 'heroImage')
  HeroImage? heroImage;

  @JsonKey(name: 'name')
  String? name;

  TopicPreview(this.slug, this.heroImage, this.name);

  factory TopicPreview.fromJson(Map<String, dynamic> srcJson) =>
      _$TopicPreviewFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TopicPreviewToJson(this);
}

@JsonSerializable()
class HeroImage extends Object {
  @JsonKey(name: 'topicKeywords')
  String? topicKeywords;

  @JsonKey(name: 'copyRight')
  bool? copyRight;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  @JsonKey(name: 'resized')
  Resized? resized;

  HeroImage(this.topicKeywords, this.copyRight, this.createdAt, this.resized);

  factory HeroImage.fromJson(Map<String, dynamic> srcJson) =>
      _$HeroImageFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeroImageToJson(this);
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
      this.original,
      this.w480,
      this.w800,
      this.w1200,
      this.w1600,
      this.w2400,
      );

  factory Resized.fromJson(Map<String, dynamic> srcJson) =>
      _$ResizedFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResizedToJson(this);
}