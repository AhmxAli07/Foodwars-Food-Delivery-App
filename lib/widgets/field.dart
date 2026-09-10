// ignore_for_file: camel_case_types, deprecated_member_use, use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_constructors

import 'package:foodwars/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Inputtext extends StatelessWidget {
  final TextEditingController mycontroller;
  final FormFieldValidator onvalidate;
  final FormFieldSetter onsubmit;
  final TextInputType keyboard;
  final String hint;
  final String? icon;
  final String? icons;
  final bool Cursor;
  final bool enable, auto;

  const Inputtext({
    Key? key, // added Key type
    required this.mycontroller,
    required this.onvalidate,
    required this.onsubmit,
    required this.keyboard,
    required this.hint,
    required this.Cursor,
    this.icon,
    this.icons,
    this.enable = true,
    this.auto = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      Color textfieldColor = themeProvider.isDarkTheme
          ? Color(0xFF252525) // Set your dark theme color
          : Color(0xFFFFFFFF); // Set your light theme color
      Color CursorColor =
          themeProvider.isDarkTheme ? Colors.white : Colors.black;
      return TextFormField(
        showCursor: Cursor,
        controller: mycontroller,
        validator: onvalidate,
        onSaved: onsubmit,
        keyboardType: keyboard,
        cursorColor: CursorColor,
        cursorWidth: 3,
        decoration: InputDecoration(
          suffixIcon: icons != null
              ? Icon(
                  // ignore: non_const_argument_for_const_parameter
                  IconData(int.parse(icons.toString()),
                      fontFamily: 'MaterialIcons'),
                  color: Color(0xFF9D9BA4),
                )
              : null,
          hintText: hint,
          prefixIconColor: Color(0xFF93E4BE),

          prefixIcon: icon != null
              ? Icon(
                  // ignore: non_const_argument_for_const_parameter
                  IconData(int.parse(icon.toString()),
                      fontFamily:
                          'MaterialIcons'), // Convert the icon to IconData
                )
              : null,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
          filled: true,
          fillColor: textfieldColor, // Set your desired color
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    });
  }
}
