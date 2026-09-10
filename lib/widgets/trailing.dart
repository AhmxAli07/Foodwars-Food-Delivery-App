// ignore_for_file: camel_case_types, prefer_const_constructors, deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';

class Trailing extends StatefulWidget {
  const Trailing({Key? key}) : super(key: key);

  @override
  State<Trailing> createState() => _TrailingState();
}

class _TrailingState extends State<Trailing> {
  int counterNumber = 0;

  void increaseCounter() {
    setState(() {
      counterNumber++;
    });
  }

  void decreaseCounter() {
    setState(() {
      if (counterNumber > 0) {
        // If the value of counterNumber is greater than 0 then Run the code.
        counterNumber--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: decreaseCounter,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 208, 255, 231)),
              child: Icon(
                Icons.remove,
                color: Colors.green,
                size: 28,
              ),
            ),
          ),
          SizedBox(width: 20),
          Text(
            "$counterNumber",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: increaseCounter,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFF4EE489)),
              child: Icon(Icons.add, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
// Color.fromARGB(255, 208, 255, 231)