import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stokis/app/splash_screen/splash_screen_controller.dart';
import 'package:stokis/shared/theme_helper.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
        init: SplashScreenController(),
        autoRemove: true,
        builder: (controller) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [primaryColor, secondaryColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                  ),
                  alignment: Alignment.center,
                  child: const SizedBox(
                    width: 200,
                    child: ImageIcon(
                      AssetImage('assets/stokin_horizontal.png'),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
