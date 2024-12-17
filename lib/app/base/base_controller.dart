import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../data/user_data.dart';
import '../routes/app_pages.dart';
import '../utils/local_storage.dart';
import '../values/color_values.dart';
import '../values/local_storage_values.dart';
import '../values/padding_values.dart';
import '../values/text_style_values.dart';

class BaseController extends GetxController {
  final DateFormat inputDateFormat = DateFormat("dd MMMM yyyy");
  final DateFormat apiDateFormat = DateFormat("dd-MM-yyyy");

  void showSuccessToast(String message) {
    if(!Get.isSnackbarOpen){
      Get.rawSnackbar(
        titleText: Container(),
        messageText: Container(
          padding: const EdgeInsets.symmetric(vertical: PaddingValues.paddingHalf, horizontal: PaddingValues.paddingHalf),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(PaddingValues.paddingHalf),
            color: ColorsValues.orange),
          child: Row(
            children: [
              Icon(Icons.check, color: ColorsValues.white),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                    message,
                    style: TextStyleValues.font12Regular.copyWith(color: ColorsValues.white)
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        snackPosition: SnackPosition.TOP,
        duration: 2.seconds
    );
    }
  }

  void showErrorToast(String message) {
    if(!Get.isSnackbarOpen){
      Get.rawSnackbar(
        titleText: Container(),
        messageText: Container(
          padding: const EdgeInsets.symmetric(vertical: PaddingValues.paddingHalf, horizontal: PaddingValues.paddingHalf),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(PaddingValues.paddingHalf),
              color: ColorsValues.redError),
          child: Row(
            children: [
              Icon(Icons.close, color: ColorsValues.white),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                    message,
                    style: TextStyleValues.font12Regular.copyWith(color: ColorsValues.white)
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        snackPosition: SnackPosition.TOP,
        duration: 2.seconds
      );
    }
  }

  UserData? getDataUser(){
    if(LocalStorage.hasData(LocalStorageValues.USER)){
      return UserData.fromJson(LocalStorage.getValue(LocalStorageValues.USER));
    } else {
      return null;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    LocalStorage.clearStorage();
    Get.offNamed(Routes.LOGIN);
  }
}