import 'package:json_annotation/json_annotation.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';

part 'editor_choices.g.dart';

@JsonSerializable()
class EditorChoice extends Object {
  @JsonKey(name: 'choices')
  Choices? choices;

  @JsonKey(name: 'heroImage')
  HeroImage? heroImage;

  @JsonKey(name: 'id')
  String? id;

  EditorChoice({this.choices, this.heroImage, this.id});

  factory EditorChoice.fromJson(Map<String, dynamic> srcJson) =>
      _$EditorChoiceFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EditorChoiceToJson(this);
}

@JsonSerializable()
class Choices extends Object {
  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'slug')
  String? slug;

  Choices({this.title, this.slug});

  factory Choices.fromJson(Map<String, dynamic> srcJson) =>
      _$ChoicesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChoicesToJson(this);
}
