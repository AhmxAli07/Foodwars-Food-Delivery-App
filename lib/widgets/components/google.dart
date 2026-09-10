// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> signInWithGoogle(BuildContext context) async {
  try {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      // User canceled the sign-in process
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the credential
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // Navigate to the desired screen after successful authentication
    // For example, you can replace `HomeScreen` with the screen you want to navigate to.
    Navigator.pushReplacementNamed(context, '/nav');
  } catch (error) {
    // Handle any errors that occur during the sign-in process
    print('Error signing in with Google: $error');
    // You can show a snackbar or dialog to inform the user about the error.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Try Another Method Sign Up is Failed.'), //$error
      ),
    );
  }
}
