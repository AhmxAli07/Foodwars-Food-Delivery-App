// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../widgets/CardTypCont.dart';
import '../widgets/customApBr.dart';

class Forget extends StatefulWidget {
  const Forget({super.key});

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomUppBar(
              customText: 'Forget password',
            ),
            CardCont(
              onpress: () {},
            ),
          ],
        ),
      ),
    );
  }
}
