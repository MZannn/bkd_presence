import 'dart:async';
import 'dart:math';

import 'package:bkd_presence/app/models/user_model.dart';
import 'package:bkd_presence/app/modules/home/provider/home_provider.dart';
import 'package:bkd_presence/app/themes/color_constants.dart';
import 'package:bkd_presence/app/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController with StateMixin<UserModel> {
  final HomeProvider _homeProvider;
  HomeController(this._homeProvider);
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxBool isLoading = false.obs;
  RxBool isWaiting = false.obs;
  RxInt selectedIndex = 0.obs;
  late DateTime now;
  late bool isMockLocation;
  late DateTime clockOut;

  late Duration difference;
  late CameraPosition cameraPosition;
  UserModel? user;
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });
    Position positon = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true);
    return positon;
  }

  Future<bool> mockGpsChecker() async {
    bool isMock = await getUserCurrentLocation().then((value) {
      return value.isMocked;
    });
    return isMockLocation = isMock;
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.openAppSettings();
      }
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
    }

    return await Geolocator.getCurrentPosition();
  }

  // check distance with haversine formula
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295; // Math.PI / 180
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }

  void checkLocationChanges() {
    Geolocator.getPositionStream(
        locationSettings: AndroidSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    )).listen((Position position) async {
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      try {
        final mock = await mockGpsChecker();
        final userPresence = state?.data?.presences?.first;

        if (userPresence?.attendanceClock == null) {
          final distance = calculateDistance(Constants.latitude,
              Constants.longitude, position.latitude, position.longitude);
          final isLate = now.hour > Constants.maxAttendanceHour;
          final entryStatus = isLate ? 'Terlambat' : '';

          if (distance <= Constants.maxAttendanceDistance && !mock) {
            if (state != null) {
              change(null, status: RxStatus.loading());
            }
            final presence = await sendAttendanceToServer(
                userPresence!.id!, position, entryStatus);
            change(
              presence,
              status: RxStatus.success(),
            );
            final message =
                isLate ? 'Anda Hadir Terlambat' : 'Anda Hadir Tepat Waktu';

            Get.rawSnackbar(
              message: message,
              backgroundColor: ColorConstants.mainColor,
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.all(16),
              borderRadius: 8,
              duration: const Duration(seconds: 3),
            );
          } else if (mock) {
            Get.rawSnackbar(
              message: 'Anda terdeteksi menggunakan fake GPS',
              backgroundColor: ColorConstants.redColor,
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.all(16),
              borderRadius: 8,
              duration: const Duration(seconds: 3),
            );
          }
        }
      } catch (e) {
        change(null, status: RxStatus.error(e.toString()));
      }
    });
  }

  Future sendAttendanceToServer(
      int id, Position position, String entryStatus) async {
    final attendanceClock = DateFormat('HH:mm:ss').format(now);
    final entryPosition = "${position.latitude}, ${position.longitude}";
    final entryDistance = calculateDistance(Constants.latitude,
        Constants.longitude, position.latitude, position.longitude);

    final presence = await _homeProvider.presenceIn(
      id,
      {
        'attendance_clock': attendanceClock,
        'entry_position': entryPosition,
        'entry_distance': entryDistance,
        'attendance_entry_status': entryStatus,
      },
    );
    return presence;
  }

  presenceOut() async {
    final userPresence = state?.data?.presences?.first;
    final exitDistance = calculateDistance(Constants.latitude,
        Constants.longitude, latitude.value, longitude.value);
    var body = {
      "attendance_clock_out": DateFormat('HH:mm:ss').format(now),
      "attendance_exit_status": "Hadir",
      "exit_position": "${latitude.value}, ${longitude.value}",
      "exit_distance": exitDistance,
    };
    try {
      if (userPresence?.attendanceClockOut == null) {
        change(null, status: RxStatus.loading());
        final presence =
            await _homeProvider.presenceOut(userPresence!.id!, body);
        change(presence, status: RxStatus.success());
        Get.rawSnackbar(
          message: 'Presensi keluar berhasil',
          backgroundColor: ColorConstants.mainColor,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      } else {
        Get.rawSnackbar(
          message: 'Anda sudah melakukan presensi keluar',
          backgroundColor: ColorConstants.redColor,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  getUser() async {
    change(null, status: RxStatus.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      final user = await _homeProvider.getUsers();
      Constants.latitude = double.parse(user!.data!.user!.office!.latitude!);
      Constants.longitude = double.parse(user.data!.user!.office!.longitude!);
      change(user, status: RxStatus.success());
      this.user = user;

      if (user.data?.user?.deviceId == null && token != null) {
        await _homeProvider.logout();
        prefs.clear();
        Get.dialog(
          AlertDialog(
            title: const Text('Permintaan Penggantian Device Anda Di Setujui'),
            content: const Text(
                'Silahkan Login Kembali Untuk Melanjutkan Penggunaan Aplikasi'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.offAllNamed('/login');
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<String> formatDate(String date) async {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate =
        DateFormat('EEEE, yyyy-MM-dd', 'id_ID').format(dateTime);

    return formattedDate;
  }

  Future<DateTime> fetchTime() async {
    var response = await _homeProvider.fetchTime();
    var dateTimeString = response['dateTime'];
    final formattedDateTimeString = dateTimeString.split('.')[0];
    final dateTime = DateTime.parse(formattedDateTimeString);
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final date = formatter.format(dateTime);
    DateTime formattedDateTime = DateTime.parse(date);
    return formattedDateTime;
  }

  Future<void> presenceOutChecker() async {
    await mockGpsChecker();
    var distance = calculateDistance(Constants.latitude, Constants.longitude,
        latitude.value, longitude.value);
    if (now.weekday == DateTime.saturday || now.weekday == DateTime.sunday) {
      Get.rawSnackbar(
        message: 'Anda tidak dapat melakukan presensi karena ini hari libur',
        backgroundColor: ColorConstants.redColor,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } else if (state?.data?.presences?.first.attendanceEntryStatus == null) {
      Get.rawSnackbar(
        message: 'Anda belum melakukan presensi masuk',
        backgroundColor: ColorConstants.redColor,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } else if (now.isBefore(clockOut)) {
      Get.rawSnackbar(
        message:
            'Anda tidak dapat melakukan presensi keluar karena belum jam 15.30',
        backgroundColor: ColorConstants.redColor,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } else if (isMockLocation == true) {
      Get.rawSnackbar(
        message: 'Anda Terdeteksi Menggunakan Fake GPS',
        backgroundColor: ColorConstants.redColor,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } else if (isMockLocation == false &&
        now.isAfter(clockOut) &&
        distance <= 0.05) {
      await presenceOut();
    } else {
      Get.rawSnackbar(
        message: 'Anda Berada Diluar Zona Presensi',
        backgroundColor: ColorConstants.redColor,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }
  }

  Future<DateTime> out() async {
    return DateTime(now.year, now.month, now.day, 15, 30, 0);
  }

  @override
  void onInit() async {
    isLoading.value = true;
    isWaiting.value = true;
    now = await fetchTime();
    clockOut = await out();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      now = now.add(const Duration(seconds: 1));
    });
    isWaiting.value = false;
    await mockGpsChecker();
    checkLocationChanges();
    await determinePosition().then((value) async {
      difference = now.difference(value.timestamp!);
      cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );
    });
    await getUser();
    isLoading.value = false;
    super.onInit();
  }
}
