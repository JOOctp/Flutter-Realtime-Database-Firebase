import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/values/color_values.dart';
import '../app/values/padding_values.dart';
import '../app/values/text_style_values.dart';


class CustomBottomSheet {

  static Future<dynamic> common({required String title, required Widget content, bool isDismissible = true}){
    return Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: ColorsValues.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(PaddingValues.paddingMain)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(PaddingValues.paddingMain),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyleValues.font16Bold,
                      ),
                    ),
                    const SizedBox(width: PaddingValues.paddingMain),
                    InkWell(
                        onTap: () => dismissBottomSheet(),
                        child: const Icon(Icons.close, color: ColorsValues.black, size: 28),
                    )
                  ],
                ),
              ),
              const Divider(color: ColorsValues.black5, height: 1),
              content
            ],
          ),
        ),
      ),
      enableDrag: isDismissible,
      isDismissible: isDismissible,
      isScrollControlled: true,
    );
  }

  static void dismissBottomSheet() {
    if (Get.isBottomSheetOpen == true) {
      Get.until((route) => !Get.isBottomSheetOpen!);
    }
  }
}