import 'package:bkd_presence/app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/presence_history_controller.dart';

class PresenceHistoryView extends GetView<PresenceHistoryController> {
  const PresenceHistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: 'Riwayat Presensi',
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ));
  }
}
