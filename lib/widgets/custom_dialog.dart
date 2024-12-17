import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/values/color_values.dart';
import '../app/values/padding_values.dart';
import '../app/values/text_style_values.dart';
import 'custom_button_outline_colored.dart';

class CustomDialog {

  static void generalAlertDialog({String title = "Peringatan", String subTitle = "", String btnConfirmText = "Oke", String btnCancelText = "Cancel", VoidCallback? btnConfirmAction, VoidCallback? btnCancelAction, bool dismissable = true}){
    FutureBuilder(
        future: Get.dialog(
          PopScope(
            canPop: dismissable,
            child: Dialog(
              backgroundColor: ColorsValues.white,
              surfaceTintColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(PaddingValues.paddingMain),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(PaddingValues.paddingHalf))
              ),
              child: Container(
                padding: const EdgeInsets.all(PaddingValues.paddingMain),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title, style: TextStyleValues.font14Bold),
                    const SizedBox(height: PaddingValues.paddingHalf),
                    Text(subTitle, style: TextStyleValues.font14Regular),
                    const SizedBox(height: PaddingValues.paddingExtra),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Visibility(
                          visible: btnCancelText.isNotEmpty,
                          child: Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: PaddingValues.paddingMain),
                              child: CustomButtonOutlineColored(
                                title: btnCancelText,
                                colorText: ColorsValues.colorPrimary,
                                colorButton: ColorsValues.white,
                                colorOutline: ColorsValues.colorPrimary,
                                action: (){
                                  Get.back();
                                  btnCancelAction?.call();
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: CustomButtonOutlineColored(
                            title: btnConfirmText,
                            colorText: ColorsValues.white,
                            colorButton: ColorsValues.colorPrimary,
                            colorOutline: ColorsValues.colorPrimary,
                            action: (){
                              Get.back();
                              btnConfirmAction?.call();
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          barrierDismissible: dismissable
        ),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) => Container()
    );
  }
}