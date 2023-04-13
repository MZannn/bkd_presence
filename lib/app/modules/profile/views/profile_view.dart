import 'package:bkd_presence/app/models/user_model.dart';
import 'package:bkd_presence/app/themes/color_constants.dart';
import 'package:bkd_presence/app/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView(this.user, {Key? key, UserModel? state}) : super(key: key);
  final UserModel? user;
  @override
  Widget build(BuildContext context) {
    String? name = user?.data?.user?.name;
    String getInitials(String userName) => userName.isNotEmpty
        ? userName.trim().split(' ').map((l) => l[0]).take(2).join()
        : '';
    getInitials(name!);
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
                          SizedBox(
                            height: 90,
                            width: 90,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: user?.data?.user?.profilePhotoPath == null
                                  ? CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Text(
                                        getInitials(name),
                                        style: textTheme.bodyLarge!.copyWith(
                                          fontSize: 28,
                                          color: ColorConstants.mainColor,
                                        ),
                                      ),
                                    )
                                  : Image.network(
                                      "https://zandev.site/storage/${user?.data?.user?.profilePhotoPath}",
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('edit-profile', arguments: {
                                'name': user?.data?.user?.name,
                                'position': user?.data?.user?.position,
                                'phoneNumber': user?.data?.user?.phoneNumber,
                                'profilePhotoPath':
                                    user?.data?.user?.profilePhotoPath,
                              });
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
                        '${user?.data?.user?.position}',
                        style:
                            textTheme.bodyMedium!.copyWith(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        '${user?.data?.user?.name}',
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        '${user?.data?.user?.phoneNumber}',
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
                          Get.toNamed('/change-device', arguments: [
                            user?.data?.user?.nip,
                            user?.data?.user?.officeId,
                          ]);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/icons/exit.svg"),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              "Ganti Device",
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
