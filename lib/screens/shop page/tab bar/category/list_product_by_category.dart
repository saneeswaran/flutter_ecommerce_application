import 'package:cloth_ecommerce_application/screens/shop%20page/tab%20bar/category/components/custom_list_tiles.dart';
import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import 'components/custom_grid_Tile.dart';
import 'components/sort_by_dialogue.dart';

class ListProductByCategory extends StatefulWidget {
  final String categoryHeading;
  const ListProductByCategory({super.key, required this.categoryHeading});

  @override
  State<ListProductByCategory> createState() => _ListProductByCategoryState();
}

class _ListProductByCategoryState extends State<ListProductByCategory> {
  String selectedSort = "Relevance";
  bool changeListTile = false;
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.categoryHeading, style: categoryShow),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          // make scrollable page
          child: Column(
            spacing: size.height * 0.01,
            children: [
              _showOthercategory(size),
              _sortList(context),

              //change layout methods
              changeListTile
                  ? GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: networkImagesFortesting.length,

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5, // Space between columns
                      childAspectRatio: 0.8, // Adjust width/height ratio
                      mainAxisExtent:
                          280, // Control item height (increase for bigger tiles)
                    ),
                    itemBuilder: (context, index) {
                      return CustomGridTile(index: index);
                    },
                  )
                  : CustomListTiles(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showOthercategory(Size size) {
    return SizedBox(
      height: size.height * 0.05, //list view contain size
      width: size.width * 1,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: clothingCategories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: categoryButtonColor,
              ),
              onPressed: () {},
              child: Text(
                clothingCategories[index],
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
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
        _filterButtons(
          title: "",
          onPressed: () {
            setState(() {
              changeListTile = !changeListTile;
            });
          },
          icon: changeListTile ? Icons.grid_3x3 : Icons.list,
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
}
