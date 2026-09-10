// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Theme/theme.dart';

class CustomUppBar extends StatelessWidget {
  final String customText;
  CustomUppBar({required this.customText});
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      Color contColor = themeProvider.isDarkTheme
          ? Color(0xFF251c13)
          : Color.fromARGB(238, 253, 245, 237);
      return SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/top.png',
              fit: BoxFit.cover,
              height: 145,
              width: double.infinity,
            ),
            Positioned(
                left: 20,
                top: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: contColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: 55,
                  height: 55,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Color(0xFFF58949),
                    ),
                  ),
                )),
            Positioned(
              left: 10,
              bottom: 25,
              child: Text(
                customText,
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.normal, fontSize: 27),
              ),
            ),
          ],
        ),
      );
    });
  }
}
