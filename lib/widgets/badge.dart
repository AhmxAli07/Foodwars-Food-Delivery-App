// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:badges/badges.dart' as badges;

class CartBadge extends StatefulWidget {
  final int badgeCount;

  const CartBadge({
    Key? key,
    required this.badgeCount,
  }) : super(key: key);

  @override
  State<CartBadge> createState() => _CartBadgeState();
}

class _CartBadgeState extends State<CartBadge> {
  @override
  Widget build(BuildContext context) {
    return widget.badgeCount > 0
        ? badges.Badge(
            position: BadgePosition.topEnd(top: -11, end: -9),
            badgeContent: Text('${widget.badgeCount}'),
            child: const Icon(
              Icons.shopping_cart,
              color: Color(0xFF31D080),
              size: 35,
            ),
          )
        : SizedBox.shrink();
  }
}
