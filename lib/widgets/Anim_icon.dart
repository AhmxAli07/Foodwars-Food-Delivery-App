// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Theme/theme.dart';

class AnimatedHeartIcon extends StatefulWidget {
  final VoidCallback onTap;

  AnimatedHeartIcon({required this.onTap});

  @override
  _AnimatedHeartIconState createState() => _AnimatedHeartIconState();
}

class _AnimatedHeartIconState extends State<AnimatedHeartIcon> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isLiked = !isLiked;
        });
        widget.onTap(); // Call the provided onTap callback
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
          : const Color.fromRGBO(
              255, 255, 255, 1); // Set your light theme color
      Color conColor =
          themeProvider.isDarkTheme ? Color(0xFF261211) : Color(0xFFFFE8E8);
      Color defaultColor = conColor; // Set your default color
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: ClipOval(
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  isLiked ? Colors.red : containerColor,
                  defaultColor,
                ],
                stops: [.1, 9],
              ),
            ),
            child: Icon(
              Icons.favorite,
              color: Colors.red,
              size: isLiked ? 20 : 20,
            ),
          ),
        ),
      );
    });
  }
}
