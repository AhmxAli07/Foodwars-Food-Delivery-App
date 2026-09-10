// ignore_for_file: camel_case_types, deprecated_member_use

import 'package:flutter/material.dart';

class round extends StatelessWidget {
  final String title;

  final VoidCallback onpress;
  final bool loading;
  const round(
      {super.key,
      required this.title,
      required this.onpress,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onpress,
      child: Container(
        height: 60,
        width: 160,
        decoration: BoxDecoration(
            color: const Color(0xFF41DB85),
            borderRadius: BorderRadius.circular(10)),
        child: loading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : Center(
                child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
              )),
      ),
    );
  }
}
