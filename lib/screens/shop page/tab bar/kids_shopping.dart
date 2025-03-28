import 'package:cloth_ecommerce_application/widgets/category_listview_builder.dart';
import 'package:flutter/material.dart';

class KidsShopping extends StatefulWidget {
  const KidsShopping({super.key});

  @override
  State<KidsShopping> createState() => _WomenShoppingState();
}

class _WomenShoppingState extends State<KidsShopping> {
  bool isBannerShow = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            spacing: size.height * 0.02,
            children: [
              isBannerShow ? _summerSaleBanner(size) : const SizedBox.shrink(),
              CategoryListviewBuilder(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summerSaleBanner(Size size) {
    return Container(
      height: size.height * 0.20,
      width: size.width * 1,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SUMMER SALES",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              "Up to 50% offer",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
