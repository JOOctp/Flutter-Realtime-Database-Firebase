import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/data/dropdown_value.dart';
import '../app/values/color_values.dart';
import '../app/values/padding_values.dart';
import '../app/values/text_style_values.dart';

class CustomTextFormFieldDropDown extends StatelessWidget {

  const CustomTextFormFieldDropDown({Key? key,
    this.label = "",
    required this.hint,
    required this.items,
    required this.onChanged,
    this.selectedItem,
    this.isAutoFloatingLabel = true,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.tintIcon,
    this.errorMessage = "",
    this.isEnable = true,
    this.isAddBottomMargin = false,

  }) : super(key: key);

  final String label;
  final String hint;
  final String? selectedItem;
  final bool isAutoFloatingLabel;
  final String? prefixIcon;
  final String? suffixIcon;
  final Color? tintIcon;
  final FocusNode? focusNode;
  final String errorMessage;
  final bool isEnable;
  final List<DropDownValue> items;
  final ValueChanged<String?> onChanged;
  final bool isAddBottomMargin;

  @override
  Widget build(BuildContext context) {
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
          DropdownButtonFormField(
            focusNode: focusNode,
            isExpanded: true,
            value: selectedItem,
            icon: suffixIcon != null ? SvgPicture.asset(
              suffixIcon!,
              width: 18,
              fit: BoxFit.scaleDown,
              colorFilter: const ColorFilter.mode(ColorsValues.black, BlendMode.srcIn),
            ) : null,
            autovalidateMode: AutovalidateMode.disabled,
            style: TextStyleValues.font14Regular.copyWith(
                color: isEnable ? ColorsValues.black : ColorsValues.black3
            ),
            hint: Text(
              hint,
              style: TextStyleValues.font14Regular.copyWith(
                  color: ColorsValues.black4
              ),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: isEnable ? ColorsValues.white : ColorsValues.greyLight,
              contentPadding: const EdgeInsets.all(PaddingValues.padding10),
              errorText: errorMessage.isNotEmpty ? errorMessage : null,
              errorStyle: TextStyleValues.font12Regular.copyWith(color: ColorsValues.redError),
              floatingLabelBehavior: isAutoFloatingLabel ? FloatingLabelBehavior.auto : FloatingLabelBehavior.never,
              prefixIcon: prefixIcon != null ? Container(
                width: 24,
                height: 24,
                padding: const EdgeInsets.all(PaddingValues.padding12),
                child: Image.asset(
                  prefixIcon!,
                  color: tintIcon ?? ColorsValues.black2,
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
            items: items.map((item) {
              return DropdownMenuItem(
                value: item.value,
                child: Text(
                  item.valueName,
                  style: TextStyleValues.font14Medium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: isEnable ? onChanged : null
          ),
        ],
      ),
    );
  }

}