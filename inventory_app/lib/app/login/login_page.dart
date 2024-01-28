import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stokis/app/login/login_controller.dart';
import 'package:stokis/shared/font_helper.dart';
import 'package:stokis/shared/theme_helper.dart';
import 'package:stokis/shared/widgets/rounded_textfield.dart';
import 'package:stokis/shared/widgets/validation_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
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
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    alignment: Alignment.center,
                    child: const SizedBox(
                      width: 200,
                      child: ImageIcon(
                        AssetImage('assets/stokin_horizontal.png'),
                        color: Colors.white,
                      ),
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
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Login',
                            style: mainFont.copyWith(
                                color: Colors.black87,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Silahkan login untuk melanjutkan\nmengakses aplikasi Stokis',
                            style: mainFont.copyWith(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            'Username',
                            style: mainFont.copyWith(
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ValidationWidget(
                            validation: controller.usernameValidation.value,
                            child: RoundedTextfield(
                              controller: controller.usernameController,
                              onChanged: (value) {
                                controller.onChangeUsername(value);
                              },
                              hintText: 'Username',
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Password',
                            style: mainFont.copyWith(
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ValidationWidget(
                            validation: controller.passwordValidatoin.value,
                            child: RoundedTextfield(
                              controller: controller.passwordController,
                              obscureText: !controller.isShowPassword.value,
                              hintText: 'Password',
                              onChanged: (value) {
                                controller.onChangePassword(value);
                              },
                              suffixWidget: GestureDetector(
                                onTap: () {
                                  controller.onChangePasswordVisibility(
                                      !controller.isShowPassword.value);
                                },
                                child: Icon(
                                  controller.isShowPassword.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: controller.isShowPassword.value
                                      ? secondaryColor
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.onLogin(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: secondaryColor),
                              alignment: Alignment.center,
                              child: Text(
                                'Login',
                                style: mainFont.copyWith(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
