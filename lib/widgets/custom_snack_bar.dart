import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

void successSnackBar() {
  AnimatedSnackBar.material(
    'Success',
    type: AnimatedSnackBarType.success,
    duration: const Duration(seconds: 3),
    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
    animationDuration: const Duration(seconds: 3),
    animationCurve: Curves.bounceIn,
  );
}

void failedSnackBar() {
  AnimatedSnackBar.material(
    'Failed',
    type: AnimatedSnackBarType.error,
    duration: const Duration(seconds: 3),
    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
    animationDuration: const Duration(seconds: 3),
    animationCurve: Curves.bounceIn,
  );
}
