// ignore_for_file: camel_case_types, deprecated_member_use, file_names

import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final VoidCallback onpress;
  final bool loading;
  const RoundButton({super.key, required this.onpress, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onpress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 60,
          width: 400,
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
                  'Add to Cart',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                )),
        ),
      ),
    );
  }
}
