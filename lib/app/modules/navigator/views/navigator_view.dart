import 'package:bkd_presence/app/modules/home/views/home_view.dart';
import 'package:bkd_presence/app/modules/profile/views/profile_view.dart';
import 'package:bkd_presence/app/themes/constants.dart';
import 'package:bkd_presence/app/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/navigator_controller.dart';

class NavigatorView extends GetView<NavigatorController> {
  const NavigatorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Themes.light.textTheme;
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: const [
            HomeView(),
            ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          child: Container(
            color: Colors.white,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    controller.selectedIndex.value = 0;
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: SvgPicture.asset(
                          'assets/icons/home${controller.selectedIndex.value == 0 ? '_active.svg' : '.svg'}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Home",
                        style: textTheme.bodySmall!.copyWith(
                          color: controller.selectedIndex.value == 0
                              ? ColorConstants.mainColor
                              : ColorConstants.greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.selectedIndex.value = 1;
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: SvgPicture.asset(
                          'assets/icons/profile${controller.selectedIndex.value == 1 ? '_active.svg' : '.svg'}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Akun",
                        style: textTheme.bodySmall!.copyWith(
                          color: controller.selectedIndex.value == 1
                              ? ColorConstants.mainColor
                              : ColorConstants.greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 0,
        backgroundColor: ColorConstants.mainColor,
        child: SvgPicture.asset("assets/icons/presence.svg"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
