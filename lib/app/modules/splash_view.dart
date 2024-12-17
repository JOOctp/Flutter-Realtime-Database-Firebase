import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../routes/app_pages.dart';
import '../values/color_values.dart';
import '../values/text_style_values.dart';

class SplashView extends GetView {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    _getDataUser();

    return Scaffold(
      backgroundColor: ColorsValues.white,
      body: Center(
        child: Text(
          'Sistem Pencatatan\nPoli Eksekutif\nRSUD Soekandar',
          textAlign: TextAlign.center,
          style: TextStyleValues.font18Bold.copyWith(
            color: ColorsValues.colorPrimary,
            fontSize: 20
          ),
        ),
      ),
    );
  }

  void _getDataUser(){
    if(FirebaseAuth.instance.currentUser != null){
      Future.delayed(const Duration(seconds: 2), () => Get.offNamed(Routes.HOME));
    } else {
      Future.delayed(const Duration(seconds: 2), () => Get.offNamed(Routes.LOGIN));
    }
  }
}
