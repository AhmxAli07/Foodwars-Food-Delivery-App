import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF15BE78);
const Color kSecondaryColor = Color(0xFFE5E5E5);
const Color klightgreyColor = Color(0xFFE5E5E5);
const Color kdarkgreyColor = Color(0xFFBDBDBD);
const Color kblackColor = Color(0xFF000000);
const Color kDarkColor = Color(0xFF0E0E0F);
const Color kwhiteColor = Color(0xFFFFFFFF);
const Color kredColor = Color(0xFFFF0000);

const ColorScheme kColorScheme = ColorScheme(
  primary: kPrimaryColor,
  secondary: kSecondaryColor,
  surface: kwhiteColor,
  error: kredColor,
  onPrimary: kwhiteColor,
  onSecondary: kwhiteColor,
  onSurface: kblackColor,
  onError: kwhiteColor,
  brightness: Brightness.light,
);

const ColorScheme kDarkColorScheme = ColorScheme(
    primary: kPrimaryColor,
    secondary: kSecondaryColor,
    surface: kblackColor,
    error: kredColor,
    onPrimary: kwhiteColor,
    onSecondary: kwhiteColor,
    onSurface: kwhiteColor,
    onError: kwhiteColor,
    brightness: Brightness.dark);

