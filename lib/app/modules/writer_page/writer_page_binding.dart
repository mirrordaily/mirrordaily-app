import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/writer_page/writer_page_controller.dart';

class WriterPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(WriterPageController());
  }


}