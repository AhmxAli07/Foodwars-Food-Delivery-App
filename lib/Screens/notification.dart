// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../widgets/customApBr.dart';

class NOTIFY extends StatefulWidget {
  const NOTIFY({super.key});

  @override
  State<NOTIFY> createState() => _NOTIFYState();
}

class _NOTIFYState extends State<NOTIFY> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomUppBar(
              customText: 'Notifications',
            ),
            Center(child: Image.asset('assets/find.png')),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "You Has Not Make Any Order Yet",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
