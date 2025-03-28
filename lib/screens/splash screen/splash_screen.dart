import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../login screen/login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then(
      (value) => Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 600),
          child: LoginPage(),
        ),
      ),
    );
    return Scaffold(body: Center(child: const Text("Splash Screens")));
  }
}
