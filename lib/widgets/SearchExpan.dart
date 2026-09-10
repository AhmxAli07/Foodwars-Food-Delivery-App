// ignore_for_file: prefer_const_constructors, avoid_print, invalid_return_type_for_catch_error, file_names, use_super_parameters

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Theme/theme.dart';

class SearchListItem extends StatelessWidget {
  final String imageUrl;
  final String itemName;
  final String price;
  final VoidCallback lead;

  const SearchListItem({
    Key? key,
    required this.imageUrl,
    required this.itemName,
    required this.price,
    required this.lead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      Color cardColor =
          themeProvider.isDarkTheme ? Color(0xFF1E1E1E) : Color(0xFFF5F5F5);
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shadowColor: cardColor,
          surfaceTintColor: cardColor,
          color: cardColor,
          child: ListTile(
              isThreeLine: true,
              leading: Image.network(imageUrl),
              title: Text(
                itemName,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 19,
                ),
              ),
              subtitle: Row(
                children: [
                  Text(
                    '\$$price',
                    style: const TextStyle(
                      color: Color(0xFF4EE489),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              trailing: InkWell(
                onTap: lead,
                child: Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF4EE489)),
                  child: Center(
                      child: Text(
                    'Add to Cart',
                    style: TextStyle(fontSize: 16),
                  )),
                ),
              )),
        ),
      );
    });
  }
}
