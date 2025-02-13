import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/enums/page_status.dart';
import 'package:mirrordaily_app/app/data/models/post_short_package.dart';
import 'package:mirrordaily_app/app/data/providers/article_gql_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class PostShortVideoResultController extends GetxController {
  PostShortPackage? package;
  final ArticleGqlProvider articleGqlProvider = Get.find();
  final Rx<PageStatus> rxPageStatus = PageStatus.normal.obs;
  final RxBool rxIsUploadSuccessful = false.obs;

  @override
  void onInit() async {
    if (Get.arguments != null) {
      package = Get.arguments;
      rxPageStatus.value = PageStatus.loading;


      if (package?.imagePreviewPath != null) {
        final photoId =
            await uploadImagePreviewAndGetImageId(package!.imagePreviewPath!);
        final result =
            await articleGqlProvider.uploadShortVideo(package!, photoId);
        if (result != null) {
          rxIsUploadSuccessful.value = true;
        }
      }
      rxPageStatus.value = PageStatus.normal;
    }
  }

  Future<int?> uploadImagePreviewAndGetImageId(String imagePath) async {
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
      'file',
      imagePath,
      contentType: MediaType('image', 'jpeg'), // 根據圖片格式修改
    );
    return await articleGqlProvider.uploadImageToGraphQL(multipartFile);
  }
}
