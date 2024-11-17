import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spotify_clone_with_flutter/presentation/register_or_signin/signin/signin.dart';

Future<void> handleLogout(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  } catch (e) {
    // Xử lý lỗi nếu có
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error logging out: $e')),
    );
  }
}
