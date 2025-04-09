import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloth_ecommerce_application/constants/constants.dart';
import 'package:cloth_ecommerce_application/model/product_model.dart';
import 'package:cloth_ecommerce_application/screens/product%20details/product_details_page.dart';
import 'package:cloth_ecommerce_application/widgets/custom_elevated_button.dart';
import 'package:cloth_ecommerce_application/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<ProductProvider>(context);
    final products = provider.items;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          spacing: size.height * 0.02, //space between widgets
          children: [
            //banner
            _fashionSale(
              size,
              height: 0.60,
              image: banner,
              text: "Fashion \nSale",
            ),
            _newAndViewAllLine(),
            _customcardsOfProduct(size, products: products),
            _fashionSale(
              size,
              height: 0.50,
              image: streetCloths,
              text: "Street Cloths",
            ),
            _customcardsOfProduct(size, products: products),
          ],
        ),
      ),
    );
  }

  Widget _fashionSale(
    Size size, {
    required double height,
    required String image,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: size.height * height,
      width: size.width * 1,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Column(
        spacing: size.height * 0.01,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.25),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
            width: size.width * 0.40,
            child: CustomElevatedButton(onPressed: () {}, text: "Check"),
          ),
        ],
      ),
    );
  }

  Widget _newAndViewAllLine() {
    return ListTile(
      title: const Text(
        "New",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "You've never seen it before",
        style: TextStyle(color: Colors.grey.shade400),
      ),
      trailing: TextButton(
        onPressed: () {},
        child: Text("View all", style: const TextStyle(color: Colors.black)),
      ),
    );
  }

  Widget _customcardsOfProduct(
    Size size, {
    required List<ProductModel> products,
  }) {
    return SizedBox(
      height: size.height * 0.5,
      width: size.width * 1,
      child: ListView.builder(
        itemCount: products.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            shadowColor: Colors.grey.shade400,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // make price details left
              children: [
                //image content
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ProductDetailsPage(
                              id: products[index].id,
                              isLiked: products[index].isLiked,
                              imageUrl: products[index].imageUrl,
                              name: products[index].name,
                              color: products[index].color,
                              price: products[index].price.toInt(),
                              rating: products[index].rating,
                              description: products[index].description,
                            ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    height: size.height * 0.30,
                    width: size.width * 0.60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          products[index].imageUrl,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    //inside the image content
                    child: _insideTheImageWithDiscountAndFavourites(
                      index: index,
                      product: products[index],
                    ),
                  ),
                ),
                //price details
                _priceDetails(size, index: index, products: products),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _insideTheImageWithDiscountAndFavourites({
    required int index,
    required ProductModel product,
  }) {
    return Align(
      alignment: Alignment.topRight, // Positions at the top-right
      child: Container(
        width: 28, // Smaller background container
        height: 28, // Smaller background container
        margin: EdgeInsets.all(5), // Adds spacing from the edges
        child: Center(
          child: Consumer<ProductProvider>(
            builder: (context, favourite, child) {
              bool isFav = favourite.isFavCheck(product.id);
              return LikeButton(
                animationDuration: const Duration(milliseconds: 400),
                isLiked: isFav,
                size: 20,
                circleColor: CircleColor(
                  start: Colors.grey.shade400,
                  end: Colors.grey.shade400,
                ),
                onTap: (liked) async {
                  if (liked) {
                    favourite.removeFromFavourites(product.id);
                    failedSnackBar(
                      text: "successfully removed from favourites",
                    );
                  } else {
                    favourite.addToFavourites(product);
                    successSnackBar(text: "successfully added to favourites");
                  }
                  return !liked;
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _priceDetails(
    Size size, {
    required int index,
    required List<ProductModel> products,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //rating bar
          StarRating(
            color: Colors.yellow.shade400,
            rating: 5,
            allowHalfRating: true,
            size: 20,
          ),
          Text(
            products[index].name,
            style: TextStyle(color: Colors.grey.shade400, fontSize: 18),
          ),
          Text(
            products[index].type,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            spacing: size.height * 0.02,
            children: [
              Text(
                "${products[index].originalPrice}",
                style: TextStyle(
                  color: Colors.grey.shade400,
                  decoration: TextDecoration.lineThrough,
                  fontSize: 18,
                ),
              ),
              Text(
                '${products[index].price}',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
