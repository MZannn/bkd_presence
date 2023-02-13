import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isHidden = false.obs;
  void hiddenPassword() {
    isHidden.value = !isHidden.value;
  }
}
