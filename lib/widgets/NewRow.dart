// ignore_for_file: deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_constructors_in_immutables, unused_import, file_names

import 'package:foodwars/widgets/Anim_button.dart';
import 'package:flutter/material.dart';
import 'Anim_icon.dart';

class CustomRow extends StatelessWidget {
  final String RowText;
  CustomRow({required this.RowText});
  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            RowText,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 27,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic),
          ),
          //   AnimatedHeartIcon()
        ],
      ),
    );
  }
}
