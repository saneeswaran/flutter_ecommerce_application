import 'package:flutter/material.dart';

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
        title: const Text(
          "Categories",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
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
          onTap: () {},
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
