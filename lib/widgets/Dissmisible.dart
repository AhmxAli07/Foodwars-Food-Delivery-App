// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Dissmissable extends StatelessWidget {
  const Dissmissable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFFfcac1e),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.delete,
                size: 35,
              ),
            )
          ],
        ));
  }
}
