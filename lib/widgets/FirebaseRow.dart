// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {
  final String itemName;
  final String price;

  const MenuItemWidget({
    required this.itemName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                itemName,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 27,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ],
          ),
        ),
        PriceWidget(price: price),
      ],
    );
  }
}

class PriceWidget extends StatelessWidget {
  final String price;

  const PriceWidget({required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 3),
          child: RichText(
            text: TextSpan(
              text: '  \$',
              style: const TextStyle(color: Color(0xFF4EE489), fontSize: 30),
              children: [
                TextSpan(
                  text: price,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: const Color.fromARGB(255, 107, 107, 107),
                        fontSize: 30,
                      ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            "Price",
            style: TextStyle(
                color: Color(0xFF4EE489),
                decoration: TextDecoration.underline,
                decorationThickness: 0.6,
                decorationColor: Color(0xFF4EE489)),
          ),
        ),
      ],
    );
  }
}
