import 'package:flutter/cupertino.dart';

import '../values/image_values.dart';

class CustomImageNetwork {

  static Widget imageNetwork({String url = "", String placeholder = ImageValues.icPlaceholder, double? width, double? height, BoxFit boxFit = BoxFit.cover}){
    return FadeInImage.assetNetwork(
      placeholder: placeholder,
      imageErrorBuilder:(context, error, stackTrace) {
        return Image.asset(placeholder,
            fit: BoxFit.cover
        );
      },
      image: url,
      width: width,
      height: height,
      fit: boxFit,
    );
  }
}