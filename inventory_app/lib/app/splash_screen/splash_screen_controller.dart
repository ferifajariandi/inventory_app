import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stokis/app/home_page/home_page.dart';
import 'package:stokis/app/login/login_page.dart';
import 'package:stokis/shared/global_data/user_logged.dart';

class SplashScreenController extends GetxController {
  navigateScreen() async {
    Future.delayed(const Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (prefs.getString('login') == null) {
        Get.to(() => const LoginPage());
      } else {
        UserLogged.setUser(json.decode(prefs.getString('login')!));
        Get.to(() => const HomePage());
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    navigateScreen();
  }
}
