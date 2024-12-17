import 'package:flutter/material.dart';

import '../app/values/color_values.dart';
import '../app/values/text_style_values.dart';

class CustomAppbar extends PreferredSize {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? appBarColor;
  final Color? textIconColor;
  final Function()? onActionButtonTap;

  CustomAppbar({
    Key? key,
    this.title,
    this.leading,
    this.actions,
    this.appBarColor,
    this.textIconColor,
    this.onActionButtonTap,
  }): super(
    key: key,
    child: const SizedBox.shrink(),
    preferredSize: Size.fromHeight(kToolbarHeight),
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
        iconTheme: IconThemeData(color: textIconColor ?? ColorsValues.white),
        actions: actions,
        leading: leading,
        actionsIconTheme: const IconThemeData(size: 18),
        backgroundColor: appBarColor ??  ColorsValues.colorPrimary,
        title: title != null ? Text(
          title!,
          style: TextStyleValues.font16Bold.copyWith(
            color: textIconColor ?? ColorsValues.white
          )
        ) : null
    );
  }
}