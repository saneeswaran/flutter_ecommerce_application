import 'package:cloth_ecommerce_application/screens/shop%20page/tab%20bar/category/list_product_by_category.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../constants/constants.dart';

class AllCategory extends StatelessWidget {
  const AllCategory({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Categories", style: categoryShow),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(children: [_listOfCategory()]),
        ),
      ),
    );
  }

  Widget _listOfCategory() {
    return ListView.builder(
      itemCount: clothingCategories.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                duration: const Duration(milliseconds: 400),
                child: ListProductByCategory(
                  categoryHeading: clothingCategories[index],
                ),
              ),
            );
          },
          child: ListTile(
            title: Text(
              clothingCategories[index],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
        );
      },
    );
  }
}
