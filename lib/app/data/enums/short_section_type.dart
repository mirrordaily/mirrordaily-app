enum ShortSectionType {
  news,
  creativity,
}

extension ShortSectionTypeExtension on ShortSectionType {
  String get value {
    return name.toString();
  }
}
