import 'package:bkd_presence/app/themes/constants.dart';
import 'package:bkd_presence/app/themes/themes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Themes.light.textTheme;
    return Scaffold(
      body: Obx(
        () {
          if (controller.isLoading.value == true) {
            return const SizedBox();
          }
          return Stack(
            children: [
              Container(
                color: ColorConstants.mainColor,
              ),
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                        left: 16,
                        bottom: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Badan Kepegawaian Daerah",
                            style: textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          "https://picsum.photos/200/300"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Jimmy Soedibjo",
                                    style: textTheme.bodyLarge,
                                  ),
                                  Text(
                                    "Staff Tata Usaha",
                                    style: textTheme.bodySmall,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: GoogleMap(
                                zoomControlsEnabled: false,
                                circles: {
                                  Circle(
                                    circleId: const CircleId("circle"),
                                    center: const LatLng(-2.215985, 113.898606),
                                    radius: 0.2 * 1000, // convert ke meter
                                    strokeWidth: 1,
                                    strokeColor: Colors.blue,
                                    fillColor: Colors.blue.withOpacity(0.1),
                                  ),
                                },
                                onCameraMove: (position) {
                                  position = controller.cameraPosition;
                                },
                                initialCameraPosition:
                                    controller.cameraPosition,
                                myLocationEnabled: true,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 8,
                                    spreadRadius: 0.1,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Masuk",
                                            style: textTheme.labelMedium,
                                          ),
                                          Text(
                                            "08:20:11",
                                            style:
                                                textTheme.bodyMedium!.copyWith(
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Terlambat",
                                            style: textTheme.labelMedium!
                                                .copyWith(
                                                    color: ColorConstants
                                                        .redColor),
                                          ),
                                          Text(
                                            "Jum'at, 21 Feb 2023",
                                            style:
                                                textTheme.bodyMedium!.copyWith(
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // ignore: prefer_const_constructors
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Keluar",
                                            style: textTheme.labelMedium,
                                          ),
                                          Text(
                                            "08:20:11",
                                            style:
                                                textTheme.bodyMedium!.copyWith(
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Jum'at, 21 Feb 2023",
                                            style:
                                                textTheme.bodyMedium!.copyWith(
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Presensi 5 hari terakhir",
                                  style: textTheme.labelMedium,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed('/presence-history');
                                  },
                                  child: const Text("Lebih banyak"),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
