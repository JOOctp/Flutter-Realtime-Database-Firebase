import 'package:intl/intl.dart';

String parseDate(String input, DateFormat formatAPI, DateFormat formatDisplay){
  try {
    var inputDate = formatAPI.parse(input, false);
    return formatDisplay.format(inputDate);
  } catch(e){
    return "-";
  }
}