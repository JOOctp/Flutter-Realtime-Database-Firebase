import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../app/values/padding_values.dart';
import '../app/values/text_style_values.dart';

class CustomButtonOutlineColored extends StatelessWidget {
  const CustomButtonOutlineColored({
    Key? key,
    required this.title,
    required this.colorText,
    required this.colorButton,
    this.isEnable = true,
    this.colorOutline,
    this.startIcon,
    this.endtIcon,
    this.action
  }) : super(key: key);

  final String title;
  final bool isEnable;
  final Color colorText;
  final Color colorButton;
  final Color? colorOutline;
  final Widget? startIcon;
  final Widget? endtIcon;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return Skeleton.shade(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnable ? action : null,
          borderRadius: BorderRadius.circular(PaddingValues.paddingHalf),
          child: Ink(
            decoration: BoxDecoration(
                color: colorButton,
                borderRadius: BorderRadius.circular(PaddingValues.paddingHalf),
                border: Border.all(
                    color: colorOutline != null ? colorOutline! : colorButton,
                    width: 1.5
                )
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: PaddingValues.padding12, horizontal: PaddingValues.paddingMain),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                    opacity: startIcon != null ? 1 : 0,
                    child: startIcon ?? endtIcon ?? Container(),
                  ),
                  Center(
                    child: Text(
                      title,
                      style: TextStyleValues.font16Bold.copyWith(
                        color: colorText
                      )
                    ),
                  ),
                  Opacity(
                    opacity: endtIcon != null ? 1 : 0,
                    child: startIcon ?? endtIcon ?? Container(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}