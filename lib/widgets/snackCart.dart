// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

class SnackBarWidget extends StatelessWidget {
  final String message;
  final Duration duration;

  const SnackBarWidget({
    required this.message,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final snackbar = AnimatedSnackBar(
      duration: duration,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFFfcac1e),
          ),
          width: 100,
          height: 50,
          child: Center(
            child: Text(
              message,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        );
      },
    );

    snackbar.show(context);

    return Container();
  }

  void show(BuildContext context) {}
}
