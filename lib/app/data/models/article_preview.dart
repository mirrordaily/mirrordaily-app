import 'package:json_annotation/json_annotation.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/core/extensions/date_extension.dart';

part 'article_preview.g.dart';

@JsonSerializable()
class ArticlePreview extends Object {
  @JsonKey(name: 'slug')
  String? slug;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'sections', defaultValue: [])
  List<Section>? sections;

  @JsonKey(name: 'heroImage')
  HeroImage? heroImage;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'publishedDate')
  String? publishedDate;

  @PartnerConverter()
  @JsonKey(name: 'partner')
  Map<String, dynamic>? partner;

  @JsonKey(name: 'categories')
  List<Category>? category;

  ArticlePreview(this.slug, this.title, this.heroImage, this.createdAt,
      this.sections, this.id, this.publishedDate, this.category, this.partner);

  factory ArticlePreview.fromJson(Map<String, dynamic> srcJson) =>
      _$ArticlePreviewFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArticlePreviewToJson(this);

  String? get formattedPublishedDate {
    if (publishedDate == null) return null;
    try {
      DateTime dateTime = DateTime.parse(publishedDate!).toLocal();
      return dateTime.toFormattedYYYYMMDDHHMMSS();
    } catch (e) {
      return null; // 解析錯誤時返回空字串
    }
  }

  bool get isExternal {
    return partner != null && partner!.isNotEmpty;
  }
}

@JsonSerializable()
class Categories extends Object {
  @JsonKey(name: 'name')
  String? name;

  Categories(this.name);

  factory Categories.fromJson(Map<String, dynamic> srcJson) =>
      _$CategoriesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CategoriesToJson(this);
}

@JsonSerializable()
class HeroImage extends Object {
  @JsonKey(name: 'resized')
  Resized? resized;

  HeroImage(
    this.resized,
  );

  factory HeroImage.fromJson(Map<String, dynamic> srcJson) =>
      _$HeroImageFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeroImageToJson(this);
}

@JsonSerializable()
class Resized extends Object {
  @JsonKey(name: 'w800')
  String? w800;

  Resized(
    this.w800,
  );

  factory Resized.fromJson(Map<String, dynamic> srcJson) =>
      _$ResizedFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResizedToJson(this);
}


class PartnerConverter implements JsonConverter<Map<String, dynamic>?, dynamic> {
  const PartnerConverter();

  @override
  Map<String, dynamic>? fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return json;
    } else if (json is String && json.trim().isEmpty) {
      return null;
    } else {
      return null;
    }
  }

  @override
  dynamic toJson(Map<String, dynamic>? object) => object;
}
