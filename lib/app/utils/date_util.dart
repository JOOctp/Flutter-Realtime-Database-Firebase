import 'package:flutter/material.dart';

import '../values/color_values.dart';

class DateUtil {
  static Future<DateTime?> datePicker({BuildContext? context, DateTime? initialDate} ) {
    return showDatePicker(
      context: context!,
      initialDate: initialDate ?? DateTime.now().toLocal(),
      firstDate: DateTime(DateTime.now().year).toLocal(),
      lastDate: DateTime(DateTime.now().year + 2).toLocal(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorsValues.colorPrimary,
              surface: ColorsValues.white,
              onPrimary: ColorsValues.white,
              onSurface: ColorsValues.black,
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          ),
        );
      },
    );
  }

}