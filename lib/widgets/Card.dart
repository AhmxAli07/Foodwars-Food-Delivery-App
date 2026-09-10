// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Theme/theme.dart';
import 'trailing.dart';

class CustomProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String resto;
  final String imageUrl;

  CustomProductCard({
    required this.name,
    required this.price,
    required this.resto,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      Color cardColor = themeProvider.isDarkTheme
          ? Color(0xFF1E1E1E) // Dark theme color
          : Color(0xFFF5F5F5); // Light theme color
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Card(
          shadowColor: cardColor,
          surfaceTintColor: cardColor,
          color: cardColor,
          child: ListTile(
              isThreeLine: true,
              title: Text(name),
              subtitle: RichText(
                text: TextSpan(
                  text: "$resto\n",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 107, 107, 107),
                    fontSize: 14,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: price,
                      style: TextStyle(
                        color: const Color(0xFF4EE489),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              leading: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
              trailing: Trailing()),
        ),
      );
    });
  }
}
