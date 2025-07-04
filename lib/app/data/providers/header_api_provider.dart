import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/helper/api_base_helper.dart';

class HeaderApiProvider extends GetxService {
  final ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  Future<List<dynamic>> getHeaderJson() async {
    final result = await apiBaseHelper.get(
        url:
            'https://storage.googleapis.com/statics-dev.mirrordaily.news/json/header.json');
    return result;
  }
}
