import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/base/my_http_overrides.dart';
import 'app/modules/splash_view.dart';
import 'app/routes/app_pages.dart';
import 'app/values/color_values.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();

  HttpOverrides.global = MyHttpOverrides();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return GetMaterialApp(
        title: "Poli Eksekutif RSUD Soekandar",
        theme: ThemeData(
          fontFamily: "Poppins",
          canvasColor: ColorsValues.white,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: ColorsValues.colorPrimary,
            selectionColor: ColorsValues.colorPrimaryAccent,
            selectionHandleColor: ColorsValues.colorPrimary,
          ),
          primaryColor: ColorsValues.colorPrimary,
        ),
        getPages: AppPages.routes,
        home: const SplashView(),
      );
  }
}
