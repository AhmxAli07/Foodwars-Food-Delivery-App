// ignore_for_file: prefer_const_constructors, file_names, non_constant_identifier_names, use_super_parameters

import 'package:foodwars/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      Color searchColor =
          themeProvider.isDarkTheme ? Color(0xFF252525) : Color(0xFFFEF6ED);
      Color textColor =
          themeProvider.isDarkTheme ? Colors.grey : Color(0xFFDA6317);
      Color iconColor =
          themeProvider.isDarkTheme ? Colors.white : Color(0xFFDA6317);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/search');
          },
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: searchColor,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: iconColor, size: 35),
                SizedBox(width: 10),
                Text(
                  'What do you want to order?',
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
