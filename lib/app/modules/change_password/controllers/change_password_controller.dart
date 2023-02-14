import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  //TODO: Implement ChangePasswordController
  final passwordController = TextEditingController();
  RxBool hiddenPassword = true.obs;
  RxBool hiddenConfirmPassword = true.obs;
  void isHiddenPass() {
    hiddenPassword.value = !hiddenPassword.value;
  }

  void isHiddenConfirmPass() {
    hiddenConfirmPassword.value = !hiddenConfirmPassword.value;
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
