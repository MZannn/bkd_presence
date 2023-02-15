import 'package:bkd_presence/app/themes/themes.dart';
import 'package:bkd_presence/app/widgets/button.dart';
import 'package:bkd_presence/app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Themes.light.textTheme;
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Edit Profile",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {},
                  child: Stack(
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          image: const DecorationImage(
                            image:
                                NetworkImage("https://picsum.photos/200/300"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
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
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Nama",
                style: textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: controller.nameController,
                enabled: false,
                style: textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFE8E8E8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                    borderSide: const BorderSide(
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(
                        0xFFA9A9A9,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Email",
                style: textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: controller.nameController,
                enabled: false,
                style: textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFE8E8E8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                    borderSide: const BorderSide(
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(
                        0xFFA9A9A9,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Bagian",
                style: textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: controller.nameController,
                enabled: false,
                style: textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFE8E8E8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                    borderSide: const BorderSide(
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(
                        0xFFA9A9A9,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              Align(
                alignment: Alignment.center,
                child: Button(
                  onPressed: () {},
                  child: Text(
                    "Simpan",
                    style: textTheme.labelMedium!.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
