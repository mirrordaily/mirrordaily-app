// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editor_choices.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditorChoice _$EditorChoiceFromJson(Map<String, dynamic> json) => EditorChoice(
      choices: json['choices'] == null
          ? null
          : Choices.fromJson(json['choices'] as Map<String, dynamic>),
      heroImage: json['heroImage'] == null
          ? null
          : HeroImage.fromJson(json['heroImage'] as Map<String, dynamic>),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$EditorChoiceToJson(EditorChoice instance) =>
    <String, dynamic>{
      'choices': instance.choices,
      'heroImage': instance.heroImage,
      'id': instance.id,
    };

Choices _$ChoicesFromJson(Map<String, dynamic> json) => Choices(
      title: json['title'] as String?,
      slug: json['slug'] as String?,
    );

Map<String, dynamic> _$ChoicesToJson(Choices instance) => <String, dynamic>{
      'title': instance.title,
      'slug': instance.slug,
    };
