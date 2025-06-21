import 'package:json_annotation/json_annotation.dart';

enum TopicLeadingType{
  @JsonValue('video')
  video,
  @JsonValue('slideshow')
  slideShow,
  @JsonValue('image')
  image,
}