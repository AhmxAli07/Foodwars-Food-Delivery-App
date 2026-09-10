// ignore_for_file: file_names, deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';

class AdjustableText extends StatelessWidget {
  final String text;

  const AdjustableText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedText = text.replaceAll('\n', ', ');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        formattedText,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 13,
            ),
      ),
    );
  }
}
