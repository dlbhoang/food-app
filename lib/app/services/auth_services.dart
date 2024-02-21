import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/auth/login_screen.dart';

class AuthMethods{
  final FirebaseAuth auth= FirebaseAuth.instance;

  getCurrentUser() async{
    return await auth.currentUser;
  }

  // ignore: non_constant_identifier_names
 Future<void> signOut(BuildContext context) async {
    await auth.signOut();
Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LogIn()),
    );  }

}