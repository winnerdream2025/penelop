
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';


class FontsStyles{
  static const fontFamily = "Manjari";



  static const TextStyle regular = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400
  );


  static TextStyle bold = const TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold
  );


  static const TextStyle medium = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500
  );


  static TextStyle black = const TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w900
  );




  static TextStyle semiBold = const TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600
  );

}


final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: FontsStyles.regular.copyWith(
    fontSize: 20,
    color: Color.fromRGBO(30, 60, 87, 1),
    fontWeight: FontWeight.w600,
  ),
  decoration: BoxDecoration(
    border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
    borderRadius: BorderRadius.circular(20),
  ),
);
