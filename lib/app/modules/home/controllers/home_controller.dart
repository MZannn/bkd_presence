import 'dart:math';

import 'package:bkd_presence/app/models/user_model.dart';
import 'package:bkd_presence/app/modules/home/provider/home_provider.dart';
import 'package:bkd_presence/app/themes/color_constants.dart';
import 'package:bkd_presence/app/themes/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController with StateMixin<UserModel> {
  final HomeProvider _homeProvider;
  HomeController(this._homeProvider);
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxBool isLoading = false.obs;
  RxInt selectedIndex = 0.obs;
  DateTime now = DateTime.now();
  late bool isMockLocation;

  late Duration difference;
  late CameraPosition cameraPosition;

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print('error : $error');
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
            print(state);
            final message =
                isLate ? 'Anda Hadir Terlambat' : 'Anda Hadir Tepat Waktu';

            Get.rawSnackbar(
              message: message,
              backgroundColor: ColorConstants.mainColor,
              snackPosition: SnackPosition.BOTTOM,
            );
          } else if (mock) {
            Get.rawSnackbar(
              message: 'Anda terdeteksi menggunakan fake GPS',
              backgroundColor: ColorConstants.redColor,
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        }
      } catch (e) {
        print('Error: $e');
        // Add error handling here
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

  getUser() async {
    change(null, status: RxStatus.loading());
    try {
      final user = await _homeProvider.getUsers();
      Constants.latitude = double.parse(user!.data!.user!.office!.latitude!);
      Constants.longitude = double.parse(user.data!.user!.office!.longitude!);
      change(user, status: RxStatus.success());
    } catch (e) {
      print(e);
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<String> formatDate(String date) async {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate =
        DateFormat('EEEE yyyy-MM-dd', 'id_ID').format(dateTime);

    return formattedDate;
  }

  @override
  void onInit() async {
    isLoading.value = true;
    await getUser();
    await mockGpsChecker();
    checkLocationChanges();
    await determinePosition().then((value) async {
      difference = now.difference(value.timestamp!);
      latitude.value = value.latitude;
      longitude.value = value.longitude;
      cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );
    });

    // getLocation();
    isLoading.value = false;
    super.onInit();
  }
}
