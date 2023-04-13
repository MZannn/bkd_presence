import 'package:bkd_presence/app/modules/change_device/provider/change_device_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeDeviceController extends GetxController {
  final ChangeDeviceProvider _changeDeviceProvider;
  ChangeDeviceController(this._changeDeviceProvider);
  late TextEditingController reasonController;

  changeDevice() async {
    var body = {
      'employee_id': Get.arguments[0],
      'office_id': Get.arguments[1],
      'reason': reasonController.text,
    };
    try {
      final changeDevice = await _changeDeviceProvider.changeDevice(body);
      if (changeDevice['status'] == 200) {
        Get.offAllNamed('/home');
      }
    } catch (e) {}
  }

  @override
  void onInit() {
    super.onInit();
    print(Get.arguments[0]);
    reasonController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
