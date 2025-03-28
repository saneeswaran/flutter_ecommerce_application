import 'package:cloth_ecommerce_application/constants/constants.dart';
import 'package:flutter/material.dart';

class CategoryListviewBuilder extends StatelessWidget {
  const CategoryListviewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categoryImages = [
      newCategory,
      shoes,
      accesories,
      clothes,
    ];
    final List<String> categoryList = ["New", "Shoes", "Accesories", "Clothes"];
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: categoryImages.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(top: 10),
          height: size.height * 0.15,
          width: size.width * 1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: size.height * 0.15,
                  width: size.width * .5,
                  child: Text(
                    categoryList[index],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                height: size.height * 0.15,
                width: size.width * .5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(categoryImages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
