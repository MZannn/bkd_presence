import 'package:bkd_presence/app/modules/login/provider/login_provider.dart';
import 'package:bkd_presence/app/themes/color_constants.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final LoginProvider _loginProvider;
  LoginController(this._loginProvider);
  final isLoading = false.obs;
  RxBool isHidden = false.obs;
  RxString deviceId = ''.obs;
  void hiddenPassword() {
    isHidden.value = !isHidden.value;
  }

  late TextEditingController nipController;
  late TextEditingController passwordController;

  Future<void> getDeviceId() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (GetPlatform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId.value = androidInfo.id;
      update();
    } else if (GetPlatform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId.value = iosInfo.identifierForVendor!;
    }
  }

  void login() async {
    try {
      final body = {
        'nip': nipController.text,
        'password': passwordController.text,
        'device_id': deviceId.value,
      };
      var response = await _loginProvider.login(body);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if (response['code'] == 200) {
        preferences.setString('token', response['data']['access_token']);
        Get.offAllNamed('/home');
      } else if (response['code'] == 401) {
        Get.rawSnackbar(
            message: 'Username Atau Password Salah',
            backgroundColor: ColorConstants.redColor,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    getDeviceId();
    nipController = TextEditingController();
    passwordController = TextEditingController();
    isLoading.value = false;
  }

  @override
  void dispose() {
    nipController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
