import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app/admin/admin_home.dart';
import 'package:food_app/admin/admin_login.dart';
import 'package:food_app/admin/see_users.dart';
import 'package:food_app/app/screens/auth/login_screen.dart';
import 'package:food_app/app/screens/splash/splash_screen.dart';

import 'package:food_app/firebase_options.dart';

import 'app/widgets/bottomnavbar.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomeAdmin()
    );
  }
}
