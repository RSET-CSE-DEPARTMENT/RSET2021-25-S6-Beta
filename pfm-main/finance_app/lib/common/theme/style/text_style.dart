import 'package:flutter/material.dart';

class AppFonts {
  static const archivo = 'Archivo';
}

const TextStyle textStyleArchivo = TextStyle(
    fontFamily: AppFonts.archivo,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Colors.black);

TextStyle get regularTextStyle => textStyleArchivo;

TextStyle get lightTextStyle =>
    textStyleArchivo.copyWith(fontWeight: FontWeight.w300);

TextStyle get mediumTextStyle =>
    textStyleArchivo.copyWith(fontWeight: FontWeight.w500);

TextStyle get semiBoldTextStyle =>
    textStyleArchivo.copyWith(fontWeight: FontWeight.w600);

TextStyle get boldTextStyle =>
    textStyleArchivo.copyWith(fontWeight: FontWeight.w700);
