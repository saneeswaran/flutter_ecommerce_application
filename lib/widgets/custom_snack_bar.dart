import 'package:animated_snack_bar/animated_snack_bar.dart';

void successSnackBar({required String text}) {
  AnimatedSnackBar.material(
    text,
    type: AnimatedSnackBarType.success,
    duration: const Duration(seconds: 3),
    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
    animationDuration: const Duration(seconds: 3),
  );
}

void failedSnackBar({required String text}) {
  AnimatedSnackBar.material(
    text,
    type: AnimatedSnackBarType.error,
    duration: const Duration(seconds: 3),
    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
    animationDuration: const Duration(seconds: 3),
  );
}
