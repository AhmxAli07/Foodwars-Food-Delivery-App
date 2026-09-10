// ignore_for_file: avoid_print, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

FacebookLogin(BuildContext context) async {
  print('Facebook');
  try {
    final result =
        await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
    if (result.status == LoginStatus.success) {
      Navigator.pushReplacementNamed(context, '/nav');
      final userData = await FacebookAuth.i.getUserData();

      print(userData);
      print(userData['name']);
      print(userData['email']);
    }
  } catch (e) {
    print(e);
  }
}
