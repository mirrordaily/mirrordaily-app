import 'package:json_annotation/json_annotation.dart';

enum TopicType {
  @JsonValue('list')
  list,
  @JsonValue('group')
  group,
}
