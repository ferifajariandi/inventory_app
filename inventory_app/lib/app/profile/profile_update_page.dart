import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stokis/app/profile/profile_update_controller.dart';
import 'package:stokis/shared/font_helper.dart';
import 'package:stokis/shared/global_data/user_logged.dart';
import 'package:stokis/shared/theme_helper.dart';
import 'package:stokis/shared/widgets/rounded_textfield.dart';
import 'package:stokis/shared/widgets/validation_widget.dart';

class ProfileUpdatePage extends StatelessWidget {
  const ProfileUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileUpdateController>(
        init: ProfileUpdateController(),
        autoRemove: true,
        builder: (controller) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [primaryColor, secondaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                  child: Text(
                                'Ubah Profil',
                                style: mainFont.copyWith(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ))
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.onPickPhoto(context);
                            },
                            child: Center(
                              child: Stack(
                                children: [
                                  controller.selectedPhoto.value != null
                                      ? Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: FileImage(File(
                                                      controller.selectedPhoto
                                                          .value!.path)))),
                                        )
                                      : UserLogged.getUser()['profile_picture']
                                              .isEmpty
                                          ? Container(
                                              width: 80,
                                              height: 80,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white),
                                              alignment: Alignment.center,
                                              child: const Icon(
                                                Icons.account_circle,
                                                color: secondaryColor,
                                              ),
                                            )
                                          : FutureBuilder(
                                              future: controller.getImageUrl(
                                                  'profiles/${UserLogged.getUser()['profile_picture']}'),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Container(
                                                    width: 80,
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white,
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                snapshot.data!),
                                                            fit: BoxFit.cover)),
                                                  );
                                                }

                                                return Container(
                                                  width: 80,
                                                  height: 80,
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.white),
                                                );
                                              }),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border:
                                              Border.all(color: primaryColor)),
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.camera_alt,
                                        color: primaryColor,
                                        size: 20,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                color: Colors.white),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'Nama',
                                          style: mainFont.copyWith(
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        ValidationWidget(
                                          validation:
                                              controller.nameValidation.value,
                                          child: RoundedTextfield(
                                            controller:
                                                controller.nameController,
                                            onChanged: (value) {
                                              controller.onNameChanged(value);
                                            },
                                            hintText: 'Nama',
                                          ),
                                        ),
                                      ]),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.onSave(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: secondaryColor),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Simpan',
                                        style: mainFont.copyWith(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
