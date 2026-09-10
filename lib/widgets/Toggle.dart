// ignore_for_file: file_names, use_key_in_widget_constructors, deprecated_member_use

import 'package:foodwars/Theme/theme.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch(
      value: themeProvider.isDarkTheme,
      onChanged: (value) {
        themeProvider.toggleTheme();
        final snackBarMessage = value ? 'Dark Theme' : 'Light Theme';
        final snackbar = AnimatedSnackBar(
          duration: const Duration(seconds: 2),
          builder: ((context) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFFfcac1e),
              ),
              width: 100,
              height: 50,
              child: Center(
                  child: Text(snackBarMessage,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600))),
            );
          }),
        );
        snackbar.show(context);
      },
    );
  }
}
