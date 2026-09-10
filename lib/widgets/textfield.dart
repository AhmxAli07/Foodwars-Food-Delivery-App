// ignore_for_file: camel_case_types, must_be_immutable, non_constant_identifier_names, use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use, library_private_types_in_public_api

import 'package:foodwars/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class inputext extends StatefulWidget {
  final TextEditingController mycontroller;
  final FormFieldValidator onvalidate;
  final FormFieldSetter onsubmit;
  final TextInputType keyboard;
  final String hint;
  final String? icon;
  final String? icons;
  final bool Cursor;
  bool obsure;
  final bool enable;
  final bool auto;

  inputext({
    required this.mycontroller,
    required this.onvalidate,
    required this.onsubmit,
    required this.keyboard,
    required this.hint,
    required this.obsure,
    required this.Cursor,
    this.icon,
    this.icons,
    this.enable = true,
    this.auto = false,
    required bool isHidden,
  });

  @override
  _inputextState createState() => _inputextState();
}

class _inputextState extends State<inputext> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      Color textfieldColor = themeProvider.isDarkTheme
          ? Color(0xFF252525) // Set your dark theme color
          : Color(0xFFFFFFFF); // Set your light theme color
      Color CursorColor =
          themeProvider.isDarkTheme ? Colors.white : Colors.black;
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: TextFormField(
          showCursor: widget.Cursor,
          controller: widget.mycontroller,
          validator: widget.onvalidate,
          onSaved: widget.onsubmit,
          keyboardType: widget.keyboard,
          obscureText: isHidden ? widget.obsure : false,
          cursorColor: CursorColor,
          cursorWidth: 3,
          decoration: InputDecoration(
            suffixIcon: widget.icons != null
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    },
                    child: Icon(
                      isHidden ? Icons.visibility : Icons.visibility_off,
                      color: Color(0xFF9D9BA4),
                    ),
                  )
                : null,
            hintText: widget.hint,
            prefixIcon: widget.icon != null
                ? Icon(
                    // ignore: non_const_argument_for_const_parameter
                    IconData(int.parse(widget.icon!),
                        fontFamily: 'MaterialIcons'),
                    color: Color(0xFF93E4BE))
                : null,
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(),
            filled: true,
            fillColor: textfieldColor,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      );
    });
  }
}
