import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:stokis/app/splash_screen/splash_screen_page.dart';
import 'package:stokis/shared/theme_helper.dart';

void configLoading(BuildContext context) {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.dualRing
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 20.0
    ..progressColor = Theme.of(context).primaryColor
    ..backgroundColor = Theme.of(context).primaryColor
    ..indicatorColor = Theme.of(context).primaryColor
    ..textColor = Theme.of(context).primaryColor
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..dismissOnTap = false;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBWhgAFS4sbZfQaWOfBrT18j4BSq0gYQC0',
          appId: '1:1018803112727:android:cf4ed243544345f51fc552',
          messagingSenderId: '1018803112727',
          storageBucket: 'gs://tugasakhir-585e2.appspot.com',
          projectId: 'tugasakhir-585e2'));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    configLoading(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'STOKIS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),
      home: const SplashScreenPage(),
    );
  }
}
