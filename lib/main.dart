import 'package:bkd_presence/app/binding/global_binding.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  initializeDateFormatting('id_ID');
  print(token);
  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: token != null ? AppPages.home : AppPages.login,
      getPages: AppPages.routes,
      initialBinding: GlobalBinding(),
    ),
  );
}
