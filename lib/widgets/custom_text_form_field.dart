import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/values/color_values.dart';
import '../app/values/padding_values.dart';
import '../app/values/text_style_values.dart';


class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({Key? key,
    this.controller,
    this.label = "",
    this.hint = "",
    this.isAutoFloatingLabel = false,
    this.inputType = TextInputType.text,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.errorMessage = "",
    this.isInputDigit = false,
    this.isHideText = false,
    this.isAddBottomMargin = false,
    this.onChanged,
    this.isEnable = true,
    this.onTap,
    this.tintIcon,
    this.onTapSuffixIcon,
    this.maxLines = 1,
    this.minLines = 1,
    this.onFieldSubmitted}) : super(key: key);

  final TextEditingController? controller;
  final String label;
  final String hint;
  final bool isAutoFloatingLabel;
  final bool isEnable;
  final String? prefixIcon;
  final String? suffixIcon;
  final TextInputType inputType;
  final bool isInputDigit;
  final FocusNode? focusNode;
  final String errorMessage;
  final Color? tintIcon;
  final int maxLines;
  final int minLines;
  final bool isHideText;
  final bool isAddBottomMargin;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onTapSuffixIcon;

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> digitOnly = [FilteringTextInputFormatter.digitsOnly];

    return Padding(
      padding: EdgeInsets.only(bottom: isAddBottomMargin ? PaddingValues.paddingHalf : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: label.isNotEmpty,
            child: Column(
              children: [
                Text(label, style: TextStyleValues.font14Medium),
                const SizedBox(height: PaddingValues.cardRadius),
              ],
            ),
          ),
          TextFormField(
            onTap: onTap,
            enabled: isEnable,
            controller: controller,
            focusNode: focusNode,
            obscureText: isHideText,
            readOnly: onTap != null,
            style: TextStyleValues.font14Regular.copyWith(
              color: isEnable ? ColorsValues.black : ColorsValues.black3
            ),
            onFieldSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyleValues.font14Regular.copyWith(
                  color:  ColorsValues.black4
              ),
              filled: true,
              fillColor: isEnable ? ColorsValues.white : ColorsValues.greyLight,
              contentPadding: const EdgeInsets.all(PaddingValues.padding10),
              errorText: errorMessage.isNotEmpty ? errorMessage : null,
              errorStyle: TextStyleValues.font12Regular.copyWith(color: ColorsValues.redError),
              floatingLabelBehavior: isAutoFloatingLabel ? FloatingLabelBehavior.auto : FloatingLabelBehavior.never,
              prefixIcon: prefixIcon != null ? SvgPicture.asset(
                prefixIcon!,
                width: 18,
                fit: BoxFit.scaleDown,
                colorFilter: ColorFilter.mode(tintIcon ?? ColorsValues.greyBlue, BlendMode.srcIn),
              ) : null,
              suffixIcon: suffixIcon != null ? InkWell(
                onTap: onTapSuffixIcon,
                child: SvgPicture.asset(
                  suffixIcon!,
                  width: 18,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(tintIcon ?? ColorsValues.greyBlue, BlendMode.srcIn),
                ),
              ) : null,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(PaddingValues.paddingHalf),
                borderSide:  const BorderSide(color: ColorsValues.greySoft, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(PaddingValues.paddingHalf),
                borderSide:  const BorderSide(color: ColorsValues.greySoft, width: 1.5),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(PaddingValues.paddingHalf),
                borderSide:  const BorderSide(color: ColorsValues.greySoft, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(PaddingValues.paddingHalf),
                borderSide:  const BorderSide(color: ColorsValues.redError),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(PaddingValues.paddingHalf),
                borderSide:  const BorderSide(color: ColorsValues.redError),
              ),
            ),
            maxLines: maxLines,
            minLines: minLines,
            keyboardType: inputType,
            onChanged: onChanged,
            inputFormatters: isInputDigit ? digitOnly : List.empty(),
          ),
        ],
      ),
    );
  }
}