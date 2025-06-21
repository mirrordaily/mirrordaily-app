import 'package:json_annotation/json_annotation.dart';
import 'package:mirrordaily_app/app/data/enums/short_type.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';

part 'short_article.g.dart';

@JsonSerializable()
class ShortArticle extends Object {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'youtubeUrl')
  String? youtubeUrl;

  @JsonKey(name: 'videoSrc')
  String? videoSrc;

  @JsonKey(name: 'publishedDate')
  String? publishedDate;

  @JsonKey(name: 'videoSection')
  String? videoSection;

  @JsonKey(name: 'heroImage')
  HeroImage? heroImage;

  String? get videoUrl {
    if (youtubeUrl != null && youtubeUrl!.trim().isNotEmpty) {
      return youtubeUrl;
    }

    if (videoSrc != null && videoSrc!.trim().isNotEmpty) {
      return videoSrc;
    }

    return null;
  }

  ShortArticle(
      {this.id,
      this.name,
      this.videoSrc,
      this.heroImage,
      this.publishedDate,
      this.videoSection,
      this.youtubeUrl});

  factory ShortArticle.fromJson(Map<String, dynamic> srcJson) =>
      _$ShortArticleFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ShortArticleToJson(this);

  ShortType get videoSourceType {
    final yt = youtubeUrl?.trim();
    final vs = videoSrc?.trim();

    if (yt != null && yt.isNotEmpty) {
      return ShortType.youtube;
    } else if (vs != null && vs.isNotEmpty) {
      return ShortType.video;
    } else {
      return ShortType.other;
    }
  }
}
