// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables, prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Theme/theme.dart';

class AnimatedLikeIcon extends StatefulWidget {
  @override
  _AnimatedLikeIconState createState() => _AnimatedLikeIconState();
}

class _AnimatedLikeIconState extends State<AnimatedLikeIcon> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isLiked = !isLiked;
        });
      },
      child: AnimatedLikeIconWidget(isLiked: isLiked),
    );
  }
}

class AnimatedLikeIconWidget extends StatelessWidget {
  final bool isLiked;

  AnimatedLikeIconWidget({required this.isLiked});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      Color containerColor = themeProvider.isDarkTheme
          ? Colors.black // Set your dark theme color
          : Colors.white; // Set your light theme color
      Color TickColor = themeProvider.isDarkTheme
          ? Colors.white
          : const Color.fromARGB(255, 0, 0, 0);
      Color defaultColor = Color(0xFF4EE489); // Set your default color
      return ClipOval(
        child: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                isLiked ? Color(0xFF4EE489) : containerColor,
                defaultColor,
              ],
              stops: [0.9, 9.9],
            ),
          ),
          child: Icon(
            Icons.check_sharp,
            color: TickColor,
            size: isLiked ? 20 : 20,
          ),
        ),
      );
    });
  }
}
