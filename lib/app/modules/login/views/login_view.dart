import 'package:bkd_presence/app/themes/themes.dart';
import 'package:bkd_presence/app/widgets/button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Themes.light.textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 75),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: textTheme.titleLarge,
                    ),
                    Text(
                      "Sistem Presensi Badan Kepegawaian Daerah Provinsi Kalimantan Tengah",
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
                Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/logo_bkd.png"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email", style: textTheme.labelMedium),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Color(0xFFA4A4A4),
                          ),
                        ),
                        hintText: "hello@gmail.com",
                        hintStyle: textTheme.bodyMedium!.copyWith(
                          color: const Color(0xFF666666),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Password",
                      style: textTheme.labelMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Obx(
                      () => TextFormField(
                        obscuringCharacter: "●",
                        obscureText: controller.isHidden.value,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Color(0xFFA4A4A4),
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.hiddenPassword();
                            },
                            icon: controller.isHidden.value
                                ? const Icon(
                                    Icons.visibility_outlined,
                                  )
                                : const Icon(
                                    Icons.visibility_off_outlined,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 36,
                ),
                Button(
                  onPressed: () {
                    Get.toNamed('/home');
                  },
                  child: Text(
                    "Masuk",
                    style: textTheme.labelMedium!.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
