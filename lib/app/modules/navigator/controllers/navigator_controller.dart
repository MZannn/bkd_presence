import 'package:get/get.dart';

class NavigatorController extends GetxController {
  RxInt selectedIndex = 0.obs;
  void setTabBarIndex(int index) {
    selectedIndex.value = index;
  }
}
