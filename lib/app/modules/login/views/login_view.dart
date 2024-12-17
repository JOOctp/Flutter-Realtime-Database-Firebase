import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:poleks/app/values/padding_values.dart';
import 'package:poleks/widgets/custom_button_outline_colored.dart';

import '../../../values/color_values.dart';
import '../../../values/image_values.dart';
import '../../../values/text_style_values.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsValues.white,
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: ColorsValues.colorPrimaryAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SvgPicture.asset(
                    width: 450,
                    ImageValues.icIllustration,
                    fit: BoxFit.scaleDown,
                  ),
                  const SizedBox(height: PaddingValues.paddingExtra),
                  Text(
                    "Melayani dengan sepenuh hati",
                    style: TextStyleValues.font18Bold.copyWith(
                      color: ColorsValues.colorPrimary
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: PaddingValues.paddingExtra),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    width: 450,
                    ImageValues.icIllustration,
                    fit: BoxFit.scaleDown,
                  ),
                  Text(
                    "Masuk menggunakan Akun Google",
                    style: TextStyleValues.font18Bold.copyWith(
                      color: ColorsValues.black
                    ),
                  ),
                  const SizedBox(height: PaddingValues.paddingMain),
                  CustomButtonOutlineColored(
                    title: "Masuk", 
                    colorText: ColorsValues.white, 
                    colorButton: ColorsValues.colorPrimary,
                    action: (){
                      controller.signInWithGoogle();
                    },
                  )
                ],
              ),
            ),
          )
        ]
      )
    );
  }
}
