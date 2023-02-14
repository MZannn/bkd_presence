import 'package:bkd_presence/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../controllers/navigator_controller.dart';

class NavigatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigatorController>(
      () => NavigatorController(),
    );
  }
}
