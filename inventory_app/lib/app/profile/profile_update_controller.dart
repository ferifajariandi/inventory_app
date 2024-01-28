import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stokis/shared/database_helper.dart';
import 'package:stokis/shared/global_data/user_logged.dart';
import 'package:stokis/shared/show_snackbar.dart';

class ProfileUpdateController extends GetxController {
  TextEditingController nameController = TextEditingController();
  Rxn<String> nameValidation = Rxn();
  Rxn<XFile> selectedPhoto = Rxn();

  Future<String> getImageUrl(String path) async {
    Reference sr = FirebaseStorage.instance.ref();
    return await sr.child(path).getDownloadURL();
  }

  onSetCurrentData() {
    nameController.text = UserLogged.getUser()['nama'];
    update();
  }

  onNameChanged(String value) {
    if (value.isEmpty) {
      nameValidation.value = 'Mohon mengisi nama Anda';
    } else {
      nameValidation.value = null;
    }

    update();
  }

  onPickPhoto(BuildContext context) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? result = await imagePicker.pickImage(source: ImageSource.gallery);

    if (result != null) {
      selectedPhoto.value = result;
      update();
    }
  }

  Future<String?> onUploadProfilePicture(Map<dynamic, dynamic> dataUser) async {
    if (selectedPhoto.value == null) {
      return dataUser['profile_picture'];
    } else {
      final storageRef = FirebaseStorage.instance.ref();
      String fileName =
          '${UserLogged.getUser()['username']}_${DateTime.now().microsecondsSinceEpoch}.png';

      final mountainImagesRef = storageRef.child(
        "profiles/$fileName",
      );

      try {
        await mountainImagesRef.putFile(
            File(selectedPhoto.value!.path),
            SettableMetadata(
              contentType: "image/jpeg",
            ));

        return fileName;
      } catch (e) {
        return null;
      }
    }
  }

  onSave(BuildContext context) async {
    onNameChanged(nameController.text);

    if (nameValidation.value == null) {
      EasyLoading.show();
      DatabaseReference ref = DatabaseHelper.accessDB()
          .ref('User/${UserLogged.getUser()['username']}');
      final snapshot = await ref.get();
      Map<dynamic, dynamic> dataUser = snapshot.value! as Map<dynamic, dynamic>;

      String? profileImage = await onUploadProfilePicture(dataUser);

      if (profileImage == null) {
        if (context.mounted) {
          EasyLoading.dismiss();
          showSnackbar(context,
              title: 'Ubah Profil',
              message: 'Gagal ubah profil, silahkan coba lagi nanti',
              customColor: Colors.orange);
        }
      } else {
        dataUser['nama'] = nameController.text;
        dataUser['profile_picture'] = profileImage;

        ref.set(dataUser);
        Map<String, dynamic> savedData = {
          'nama': nameController.text,
          'profile_picture': profileImage,
          'role': dataUser['role'],
          'username': UserLogged.getUser()['username']
        };
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('login', json.encode(savedData));
        UserLogged.setUser(savedData);

        EasyLoading.dismiss();
        Get.back();
        if (context.mounted) {
          showSnackbar(context,
              customColor: Colors.green,
              message: 'Berhasil merubah profil',
              title: 'Ubah Profil');
        }
      }
    } else {
      showSnackbar(context,
          title: 'Ubah Profil',
          message: 'Mohon cek kembali isian Anda',
          customColor: Colors.orange);
    }
  }

  @override
  void onInit() {
    super.onInit();
    onSetCurrentData();
  }
}
