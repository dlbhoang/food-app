import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app/admin/admin_home.dart';
import 'package:food_app/admin/admin_login.dart';
import 'package:food_app/app/screens/wallet/wallet_screen.dart';
import 'package:food_app/firebase_options.dart';

import 'app/screens/home/home_screen.dart';
import 'app/screens/auth/login_screen.dart';
import 'app/screens/auth/signup_screen.dart';
import 'app/screens/order/order_screen.dart';
import 'app/screens/splash/splash_screen.dart';
import 'app/widgets/bottomnavbar.dart'; // Import Firebase Auth

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
      home:HomeScreen()
    );
  }
}
