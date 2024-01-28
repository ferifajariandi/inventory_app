import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stokis/app/home_page/home_page.dart';
import 'package:stokis/shared/database_helper.dart';
import 'package:stokis/shared/global_data/user_logged.dart';
import 'package:stokis/shared/show_snackbar.dart';

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Rx<bool> isShowPassword = Rx(false);
  Rxn<String> usernameValidation = Rxn(null);
  Rxn<String> passwordValidatoin = Rxn(null);

  onChangeUsername(String value) {
    if (value.isEmpty) {
      usernameValidation.value = 'Mohon mengisi username';
    } else {
      usernameValidation.value = null;
    }
    update();
  }

  onChangePassword(String value) {
    if (value.isEmpty) {
      passwordValidatoin.value = 'Mohon mengisi password';
    } else {
      passwordValidatoin.value = null;
    }
    update();
  }

  onChangePasswordVisibility(bool value) {
    isShowPassword.value = value;
    update();
  }

  createSession(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('login', json.encode(data));

    UserLogged.setUser(data);
  }

  onLogin(BuildContext context) async {
    onChangeUsername(usernameController.text);
    onChangePassword(passwordController.text);

    if (usernameValidation.value == null && passwordValidatoin.value == null) {
      DatabaseReference ref =
          DatabaseHelper.accessDB().ref('User/${usernameController.text}');

      EasyLoading.show();
      final snapshot = await ref.get();
      EasyLoading.dismiss();

      if (snapshot.exists) {
        Map<dynamic, dynamic> dataUser =
            snapshot.value! as Map<dynamic, dynamic>;

        if (dataUser['password'] == passwordController.text) {
          createSession({
            'nama': dataUser['nama'],
            'profile_picture': dataUser['profile_picture'],
            'role': dataUser['role'],
            'username': usernameController.text
          });

          if (context.mounted) {
            Get.off(() => const HomePage());
            showSnackbar(context,
                title: 'Login',
                message: 'Login Berhasil',
                customColor: Colors.green);
          }
        } else {
          if (context.mounted) {
            showSnackbar(context,
                title: 'Login',
                message: 'Username dan Password tidak cocok',
                customColor: Colors.orange);
          }
        }
      } else {
        if (context.mounted) {
          showSnackbar(context,
              title: 'Login',
              message: 'Username tidak ditemukan',
              customColor: Colors.orange);
        }
      }
    } else {
      showSnackbar(context,
          title: 'Login',
          message: 'Mohon cek kembali isian Anda',
          customColor: Colors.orange);
    }
  }
}
