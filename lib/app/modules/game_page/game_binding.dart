import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/game_page/game_controller.dart';

class GameBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GameController());
  }
}
