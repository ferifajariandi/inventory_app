import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stokis/app/home_page/home_controller.dart';
import 'package:stokis/shared/font_helper.dart';
import 'package:stokis/shared/global_data/user_logged.dart';
import 'package:stokis/shared/theme_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
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
                    const SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: UserLogged.getUser()['profile_picture'].isEmpty
                          ? Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
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
                                            image: NetworkImage(snapshot.data!),
                                            fit: BoxFit.cover)),
                                  );
                                }

                                return Container(
                                  width: 80,
                                  height: 80,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                );
                              }),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      UserLogged.getUser()['nama'].toString(),
                      style: mainFont.copyWith(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      UserLogged.getUser()['role'].toString().toUpperCase(),
                      style: mainFont.copyWith(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
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
                            height: 20,
                          ),
                          Text(
                            'Menu',
                            style: mainFont.copyWith(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Wrap(
                            runSpacing: 8,
                            children: List.generate(controller.dataMenu.length,
                                (index) {
                              return FractionallySizedBox(
                                widthFactor: 0.33,
                                child: GestureDetector(
                                  onTap: () {
                                    controller
                                        .onMenuTap(controller.dataMenu[index]);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        FractionallySizedBox(
                                          widthFactor: 0.8,
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: primaryColor
                                                      .withOpacity(0.3)),
                                              alignment: Alignment.center,
                                              child: Icon(
                                                controller.getMenuIcon(
                                                    controller.dataMenu[index]),
                                                color: secondaryColor,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          controller.getMenuTitle(
                                              controller.dataMenu[index]),
                                          style: mainFont.copyWith(
                                              fontSize: 11,
                                              color: Colors.black87),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.onLogout(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Logout',
                                    style: mainFont.copyWith(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
