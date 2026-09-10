// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names

import 'package:foodwars/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomContainer extends StatelessWidget {
  final String imagepath;
  final String title;
  final String price;
  final String Nav;

  CustomContainer({
    required this.imagepath,
    required this.title,
    required this.price,
    required this.Nav,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      Color containerColor = themeProvider.isDarkTheme
          ? Color(0xFF252525) // Set your dark theme color
          : Colors.white; // Set your light theme color
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, Nav);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 160,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: containerColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagepath,
                  width: 80, // adjust the width as needed
                  height: 80, // adjust the height as needed
                ),
                SizedBox(height: 5),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 7),
                Text(
                  '\$$price',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
