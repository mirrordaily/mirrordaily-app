import 'package:json_annotation/json_annotation.dart';

part 'short_article.g.dart';


@JsonSerializable()
class ShortArticle extends Object {

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'videoSrc')
  String? videoSrc;

  @JsonKey(name: 'uploader')
  String? uploader;

  @JsonKey(name: 'uploaderEmail')
  String? uploaderEmail;

  ShortArticle({this.id,this.name,this.videoSrc,this.uploader,this.uploaderEmail});

  factory ShortArticle.fromJson(Map<String, dynamic> srcJson) => _$ShortArticleFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ShortArticleToJson(this);

}


