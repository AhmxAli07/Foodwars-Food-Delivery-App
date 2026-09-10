// ignore_for_file: file_names, use_super_parameters, non_constant_identifier_names, prefer_const_constructors

import 'package:foodwars/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomSearchBarTwo extends StatefulWidget {
  const CustomSearchBarTwo({
    Key? key,
    required this.onChanged,
  }) : super(key: key);
  final void Function(String value) onChanged;

  @override
  State<CustomSearchBarTwo> createState() => _CustomSearchBarTwoState();
}

class _CustomSearchBarTwoState extends State<CustomSearchBarTwo> {
  late FocusNode _focusNode; // Declare a FocusNode instance

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(); // Initialize the FocusNode
    _focusNode.requestFocus(); // Request focus for the TextField
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Dispose the FocusNode when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      Color SearchColor = themeProvider.isDarkTheme
          ? Color(0xFF252525) // Set your dark theme color
          : Color(0xFFFEF6ED); // Set your light theme color
      Color textColor =
          themeProvider.isDarkTheme ? Colors.grey : Color(0xFFDA6317);
      Color iconColor =
          themeProvider.isDarkTheme ? Colors.white : Color(0xFFDA6317);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SearchBar(
          onChanged: widget.onChanged,
          hintStyle: WidgetStateProperty.all(TextStyle(color: textColor)),
          elevation: WidgetStateProperty.all(0),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          backgroundColor: WidgetStateProperty.all(SearchColor),
          hintText: 'What do you want to order?',
          leading: Icon(Icons.search, color: iconColor, size: 35),
          focusNode: _focusNode, // Assign the FocusNode to the TextField
        ),
      );
    });
  }
}
