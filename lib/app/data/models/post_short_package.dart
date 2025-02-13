
import 'package:image_picker/image_picker.dart';

class PostShortPackage {
  String? name;
  String? email;
  String? title;
  String? description;
  String? imagePreviewPath;
  XFile? videoXFile;

  PostShortPackage(
      {this.description,
      this.title,
      this.name,
      this.email,
      this.videoXFile,
      this.imagePreviewPath});
}
