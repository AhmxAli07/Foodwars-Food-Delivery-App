// ignore_for_file: deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class CustomTitleRow extends StatelessWidget {
  final String RowText;
  CustomTitleRow({required this.RowText});
  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            RowText,
            style:
                Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16),
          ),
          Text(
            "View more",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Color(0xFFF58949), fontSize: 14),
          ),
        ],
      ),
    );
  }
}
