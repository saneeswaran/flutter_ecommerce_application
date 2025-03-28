import 'package:cloth_ecommerce_application/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/login screen/provider/login_provider.dart';
import 'screens/splash screen/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LoginProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'cloth ecommerce application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        primaryColor: buttonColor,
      ),
      home: const SplashScreen(),
    );
  }
}
