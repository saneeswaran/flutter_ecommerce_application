import 'package:cloth_ecommerce_application/constants/constants.dart';
import 'package:cloth_ecommerce_application/providers/product_provider.dart';
import 'package:cloth_ecommerce_application/screens/product%20details/product_details_page.dart';
import 'package:cloth_ecommerce_application/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
    final provider = Provider.of<ProductProvider>(context);
    final favourites = provider.favourite;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Favourite",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body:
          favourites.isEmpty
              ? _noFavList()
              : SingleChildScrollView(
                child: Column(
                  children: [
                    _sortList(context),
                    ListView.builder(
                      itemCount: favourites.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return _favouriteList(
                          size: size,
                          index: index,
                          provider: provider,
                        );
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

  Widget _favouriteList({
    required Size size,
    required int index,
    required ProductProvider provider,
  }) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ProductDetailsPage(
                    id: provider.favourite[index].id,
                    imageUrl: provider.favourite[index].imageUrl,
                    color: provider.favourite[index].color,
                    name: provider.favourite[index].name,
                    price: provider.favourite[index].price.toInt(),
                    rating: provider.favourite[index].rating.toDouble(),
                    description: provider.favourite[index].description,
                    isLiked: provider.favourite[index].isLiked,
                  ),
            ),
          ),
      child: Container(
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
                  image: NetworkImage(provider.favourite[index].imageUrl),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            _productDetails(size: size, index: index, provider: provider),
            _favouriteButton(size, provider: provider, index: index),
          ],
        ),
      ),
    );
  }

  Widget _productDetails({
    required Size size,
    required int index,
    required ProductProvider provider,
  }) {
    final product = provider.favourite.elementAt(index);

    return Container(
      height: size.height * 0.15,
      width: size.width * 0.52,
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: Column(
        spacing: size.height * 0.01,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.name, style: TextStyle(color: Colors.grey.shade700)),
          Text(product.type, style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            spacing: size.width * 0.03,
            children: [
              _customRichText(
                text: "Color: ",
                productDetailText: product.color,
              ),
              _customRichText(text: "Size: ", productDetailText: product.size),
            ],
          ),
          Row(
            spacing: size.width * 0.05,
            children: [
              Text("${product.price}"),
              StarRating(
                allowHalfRating: true,
                rating: product.rating,
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

  Widget _favouriteButton(
    Size size, {
    required ProductProvider provider,
    required int index,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: size.width * 0.09,
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              provider.removeFromFavourites(provider.favourite[index].id);
              successSnackBar(text: "Product removed successfully");
            },
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
            onPressed: () {
              provider.addToCart(provider.favourite[index]);
              successSnackBar(text: "Product added to cart successfully");
            },
            icon: Icon(Icons.shopping_cart),
            tooltip: "Add to Cart",
            color: Colors.white,
            iconSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _noFavList() {
    return Center(child: SvgPicture.asset(noFavourites, fit: BoxFit.cover));
  }
}
