import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  RxBool isLoading = false.obs;
  RxInt selectedIndex = 0.obs;
  late CameraPosition cameraPosition;
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print('error : $error');
    });
    return await Geolocator.getCurrentPosition();
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

  @override
  void onInit() async {
    isLoading.value = true;
    await determinePosition().then((value) async {
      latitude.value = value.latitude;
      longitude.value = value.longitude;
      cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );
    });
    isLoading.value = false;
    super.onInit();
  }
}
