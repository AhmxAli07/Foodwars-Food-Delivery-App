// ignore_for_file: camel_case_types, file_names, use_super_parameters, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Theme/theme.dart';

class picCont extends StatefulWidget {
  final VoidCallback onpress;
  final String name;
  final String photo;
  const picCont({
    Key? key,
    required this.onpress,
    required this.name,
    required this.photo,
  }) : super(key: key);

  @override
  State<picCont> createState() => _picContState();
}

class _picContState extends State<picCont> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      Color cardContColor =
          themeProvider.isDarkTheme ? Color(0xFF252525) : Colors.white;
      return GestureDetector(
        onTap: widget.onpress,
        child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 20),
          width: 350,
          height: 130,
          decoration: BoxDecoration(
              color: cardContColor, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(widget.photo),
                SizedBox(
                  height: 10,
                ),
                Text(widget.name),
              ],
            ),
          ),
        ),
      );
    });
  }
}
