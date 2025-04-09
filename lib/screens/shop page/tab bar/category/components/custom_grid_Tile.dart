import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import '../../../../../model/product_model.dart';
import '../../../../../providers/product_provider.dart';
import '../../../../../widgets/custom_snack_bar.dart';
import '../../../../product details/product_details_page.dart';

class CustomGridTile extends StatelessWidget {
  final int index;
  const CustomGridTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final products = provider.items;
    Size size = MediaQuery.of(context).size;
    return Container(
      child: _customcardsOfProduct(
        size,
        context,
        index: index,
        products: products[index],
      ),
    );
  }

  Widget _customcardsOfProduct(
    Size size,
    BuildContext context, {
    required int index,
    required ProductModel products,
  }) {
    return SizedBox(
      height: size.height * 0.36,
      width: size.width * 1,
      child: Column(
        children: [
          Card(
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
                              id: products.id,
                              imageUrl: products.imageUrl,
                              color: products.color,
                              name: products.name,
                              price: products.price.toInt(),
                              rating: products.rating.toDouble(),
                              description: products.description,
                              isLiked: products.isLiked,
                            ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),

                    //image size
                    height: size.height * 0.20,
                    width: size.width * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(products.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    //inside the image content
                    child: _insideTheImageWithDiscountAndFavourites(
                      product: products,
                    ),
                  ),
                ),
                //price details
                _priceDetails(size, context, index: index, products: products),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _insideTheImageWithDiscountAndFavourites({
    required ProductModel product,
  }) {
    return Align(
      alignment: Alignment.topRight, // Positions at the top-right
      child: Container(
        width: 28, // Smaller background container
        height: 28, // Smaller background container
        margin: EdgeInsets.all(5), // Adds spacing from the edges
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
                  failedSnackBar(text: "successfully removed from favourites");
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
    );
  }

  Widget _priceDetails(
    Size size,
    BuildContext context, {
    required int index,
    required ProductModel products,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //rating bar
          Row(
            //make align star rating at the left side
            children: [
              StarRating(
                color: Colors.yellow.shade400,
                rating: 5,
                allowHalfRating: true,
                size: 15,
              ),
            ],
          ),
          Text(products.name, style: TextStyle(color: Colors.grey.shade400)),
          Text(
            products.type,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            spacing: size.height * 0.02,
            children: [
              Text(
                "${products.originalPrice}",
                style: TextStyle(
                  color: Colors.grey.shade400,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Text(
                '${products.price}',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
