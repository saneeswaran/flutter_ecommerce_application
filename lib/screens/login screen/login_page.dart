import 'package:cloth_ecommerce_application/constants/constants.dart';
import 'package:cloth_ecommerce_application/screens/bottom%20nav%20bar/bottom_navi_bar.dart';
import 'package:cloth_ecommerce_application/screens/login%20screen/provider/login_provider.dart';
import 'package:cloth_ecommerce_application/widgets/custom_elevated_button.dart';
import 'package:cloth_ecommerce_application/widgets/custom_textForm_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../register screen/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    void moveToNextPage() {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
          child: BottomNaviBar(),
        ),
      );
    }

    final loginProvider = Provider.of<LoginProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            spacing: size.height * 0.03, // giving space between widgets
            crossAxisAlignment: CrossAxisAlignment.start, //make alignment left
            children: [
              SizedBox(height: size.height * 0.15),
              Text(
                "Login",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.015),
              //fields
              CustomTextformField(
                controller: loginProvider.emailController,
                labelText: "Email",
              ),
              CustomTextformField(
                controller: loginProvider.passwordController,
                labelText: "Password",
              ),
              _alreadyHaveAnAccount(context),
              Center(
                child: SizedBox(
                  height: size.height * 0.07,
                  width: size.width * 0.7,
                  child: CustomElevatedButton(
                    onPressed: moveToNextPage,
                    text: "LOGIN",
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.07),
              Center(
                child: const Text(
                  "Or login with social account",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              signInWithSocialMethods(size),
            ],
          ),
        ),
      ),
    );
  }

  Widget _alreadyHaveAnAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end, //make alignment righ
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 600),
                child: const RegisterPage(),
              ),
            );
          },
          child: Text(
            "Create an account",
            style: TextStyle(color: Colors.black),
          ),
        ),
        Icon(Icons.arrow_forward_sharp, color: Colors.red),
      ],
    );
  }

  Widget signInWithSocialMethods(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _socialMethodContainer(
            size,
            SvgPicture.asset(
              googleSvgIcon,
              height: 5,
              width: 5,
              fit: BoxFit.scaleDown,
            ),
          ),
          _socialMethodContainer(
            size,
            Icon(Icons.facebook, color: Colors.blue, size: 30),
          ),
        ],
      ),
    );
  }

  Widget _socialMethodContainer(Size size, Widget iconWidget) {
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: iconWidget,
    );
  }
}
