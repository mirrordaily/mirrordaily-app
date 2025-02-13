import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/providers/article_api_provider.dart';
import 'package:mirrordaily_app/app/data/providers/article_gql_provider.dart';
import 'package:mirrordaily_app/app/data/providers/grapg_ql_provider.dart';
import 'package:mirrordaily_app/app/data/providers/local_cache_provider.dart';
import 'package:mirrordaily_app/configs/environment.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Environment());
    Get.put(GraphQLProvider());
    Get.put(ArticleApiProvider());
    Get.put(ArticleGqlProvider());
    Get.put(LocalCacheProvider.instance);
  }
}
