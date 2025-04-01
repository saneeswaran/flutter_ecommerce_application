import 'package:cloth_ecommerce_application/constants/constants.dart';
import 'package:cloth_ecommerce_application/model/fake_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

import '../shop page/tab bar/category/components/sort_by_dialogue.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  void sortProducts(String sortType) {
    // setState(() {
    //   selectedSort = sortType;
    //   if (sortType == "Price -- Low to High") {
    //     products.sort((a, b) => a["price"].compareTo(b["price"]));
    //   } else if (sortType == "Price -- High to Low") {
    //     products.sort((a, b) => b["price"].compareTo(a["price"]));
    //   }
    //   // Add other sorting conditions as needed
    // });
  }
  String selectedSort = "Relevance";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Favourite",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _sortList(context),
            ListView.builder(
              itemCount: networkImagesFortesting.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return _favouriteList(size, index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Row _filterButtons({
    required String title,
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    return Row(
      children: [
        IconButton(onPressed: onPressed, icon: Icon(icon)),
        Text(title),
      ],
    );
  }

  Widget _sortList(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _filterButtons(
          title: "Filter",
          onPressed: () {},
          icon: Icons.filter_list,
        ),
        _filterButtons(
          title: "Price lowest to high",
          onPressed: () {
            showSortByDialog(context, selectedSort, sortProducts);
          },
          icon: Icons.keyboard_arrow_down,
        ),
      ],
    );
  }

  void showSortByDialog(
    BuildContext context,
    String currentSort,
    Function(String) onSortSelected,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SortByDialogue(
          selectedSort: currentSort,
          onSortSelected: onSortSelected,
        );
      },
    );
  }

  Container _favouriteList(Size size, int index) {
    return Container(
      //outside container
      margin: const EdgeInsets.all(10),
      height: size.height * 0.15,
      width: size.width * 1,
      decoration: BoxDecoration(
        //  color: Colors.red, --> for testing layouts
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image container
          Container(
            height: size.height * 0.15,
            width: size.width * 0.30,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(networkImagesFortesting[index]),
                fit: BoxFit.contain,
              ),
            ),
          ),
          _productDetails(size, index: index),
          _favouriteButton(size),
        ],
      ),
    );
  }

  Widget _productDetails(Size size, {required int index}) {
    return Container(
      height: size.height * 0.15,
      width: size.width * 0.52,
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: Column(
        spacing: size.height * 0.01,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            testingfakeModel[index].name,
            style: TextStyle(color: Colors.grey.shade700),
          ),
          Text(
            testingfakeModel[index].type,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            spacing: size.width * 0.03,
            children: [
              _customRichText(
                text: "Color: ",
                productDetailText: testingfakeModel[index].color,
              ),
              _customRichText(
                text: "Size: ",
                productDetailText: testingfakeModel[index].size,
              ),
            ],
          ),
          Row(
            spacing: size.width * 0.05,
            children: [
              Text("${testingfakeModel[index].price}"),
              StarRating(
                allowHalfRating: true,
                rating: 5,
                color: Colors.yellow.shade400,
                size: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _customRichText({
    required String text,
    required String productDetailText,
  }) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
          TextSpan(
            text: productDetailText,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _favouriteButton(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: size.width * 0.09,
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
            tooltip: "Remove from faourites",
            iconSize: 20,
          ),
        ),
        Container(
          width: size.width * 0.09,
          decoration: BoxDecoration(color: Colors.pink, shape: BoxShape.circle),
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
            tooltip: "Add to Cart",
            color: Colors.white,
            iconSize: 20,
          ),
        ),
      ],
    );
  }
}
