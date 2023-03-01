import 'package:bkd_presence/app/themes/color_constants.dart';
import 'package:bkd_presence/app/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Themes.light.textTheme;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            color: ColorConstants.mainColor,
          ),
          SafeArea(
            child: Column(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorConstants.mainColor,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 27,
                      ),
                      Text(
                        "Profile",
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              image: const DecorationImage(
                                image: NetworkImage(
                                    "https://picsum.photos/200/300"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('edit-profile');
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              margin: const EdgeInsets.only(top: 55, left: 55),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(
                                  30,
                                ),
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Staff",
                        style:
                            textTheme.bodyMedium!.copyWith(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Jimmy Soedibjo",
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "dibjosoe123@gmail.com",
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed('/change-password');
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/icons/edit.svg"),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              "Ubah Password",
                              style: textTheme.bodyLarge!.copyWith(
                                color: const Color(0xFF383838),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed('/login');
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/icons/exit.svg"),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              "Keluar",
                              style: textTheme.bodyLarge!.copyWith(
                                color: const Color(0xFF383838),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
