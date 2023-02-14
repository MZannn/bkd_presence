import 'package:bkd_presence/app/themes/constants.dart';
import 'package:bkd_presence/app/themes/themes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Themes.light.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Password'),
        centerTitle: true,
        backgroundColor: ColorConstants.mainColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Password Baru",
                style: textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              Obx(
                () => TextFormField(
                  controller: controller.passwordController,
                  obscureText: controller.hiddenPassword.value,
                  obscuringCharacter: "●",
                  style: textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.isHiddenPass();
                      },
                      icon: controller.hiddenPassword.value
                          ? const Icon(
                              Icons.visibility_outlined,
                            )
                          : const Icon(
                              Icons.visibility_off_outlined,
                            ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                      borderSide: const BorderSide(
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Color(
                          0xFFA9A9A9,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "Konfirmasi Password Baru",
                style: textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              Obx(
                () => TextFormField(
                  controller: controller.passwordController,
                  obscureText: controller.hiddenConfirmPassword.value,
                  obscuringCharacter: "●",
                  style: textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.isHiddenConfirmPass();
                      },
                      icon: controller.hiddenConfirmPassword.value
                          ? const Icon(
                              Icons.visibility_outlined,
                            )
                          : const Icon(
                              Icons.visibility_off_outlined,
                            ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                      borderSide: const BorderSide(
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Color(
                          0xFFA9A9A9,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}