import 'package:json_annotation/json_annotation.dart';
import 'package:mirrordaily_app/app/data/enums/topic_leading_type.dart';
import 'package:mirrordaily_app/app/data/enums/topic_type.dart';
import 'package:mirrordaily_app/app/data/models/topic_preview.dart';

part 'topic.g.dart';

@JsonSerializable()
class Topic extends Object {
  @JsonKey(name: 'type', defaultValue: TopicType.list)
  TopicType? type;

  @JsonKey(name: 'leading', defaultValue: TopicLeadingType.image)
  TopicLeadingType? leading;

  @JsonKey(name: 'tags', defaultValue: [])
  List<Tag> tags;

  @JsonKey(name: 'posts', defaultValue: [])
  List<Posts> posts;

  @JsonKey(name: 'slideshow_images', defaultValue: [])
  List<Resized> slideshowImageList;

  @JsonKey(name: 'heroImage')
  HeroImage? heroImage;

  @JsonKey(name: 'heroVideo')
  HeroVideo? heroVideo;

  Topic(this.type, this.leading, this.posts, this.slideshowImageList,
      this.heroImage, this.heroVideo, this.tags);

  factory Topic.fromJson(Map<String, dynamic> srcJson) =>
      _$TopicFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TopicToJson(this);

  String? get imageUrl => heroImage?.resized?.w800;

  String? get videoUrl => heroVideo?.videoSrc;


  Map<String, List<Posts>> get getGroupPost {
    Map<String, List<Posts>> result = {};
    if (tags.isNotEmpty) {
      for (var tag in tags) {
        result[tag.name] = [];
      }
    }

    if (posts.isNotEmpty) {
      for (var post in posts) {
        final postTags = post.tags;
        if (postTags.isNotEmpty) {
          for (var postTag in postTags) {
            if (result.containsKey(postTag.name)) {
              result[postTag.name]!.add(post);
            }
          }
        }
      }
    }

    return result;
  }
}

@JsonSerializable()
class Posts extends Object {
  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'subtitle')
  String? subtitle;

  @JsonKey(name: 'slug')
  String? slug;
  @JsonKey(name: 'tags', defaultValue: [])
  List<Tag> tags;

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'heroImage')
  HeroImage? heroImage;
  @JsonKey(name: 'apiDataBrief', defaultValue: [])
  List<dynamic>? apiDataBrieList;

  Posts(this.apiDataBrieList, this.title, this.tags, this.slug, this.heroImage,
      this.subtitle, this.id);

  factory Posts.fromJson(Map<String, dynamic> srcJson) =>
      _$PostsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PostsToJson(this);



  String? get briefText {
    if (apiDataBrieList == null || apiDataBrieList!.isEmpty) return null;

    try {
      final contents = apiDataBrieList!
          .whereType<Map<String, dynamic>>()
          .map((e) => e['content'])
          .whereType<List<dynamic>>()
          .expand((list) => list)
          .whereType<String>()
          .toList();

      if (contents.isEmpty) return null;

      return contents.join('\n'); // 或用 ' ' 依你格式需求決定
    } catch (e) {
      return null;
    }
  }
}

@JsonSerializable()
class HeroVideo {
  @JsonKey(name: 'videoSrc')
  String? videoSrc;

  HeroVideo(this.videoSrc);

  factory HeroVideo.fromJson(Map<String, dynamic> srcJson) =>
      _$HeroVideoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeroVideoToJson(this);
}

@JsonSerializable()
class Tag extends Object {
  @JsonKey(name: 'name')
  String name;

  Tag(
    this.name,
  );

  factory Tag.fromJson(Map<String, dynamic> srcJson) => _$TagFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}
