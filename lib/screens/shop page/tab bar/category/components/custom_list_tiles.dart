import 'package:cloth_ecommerce_application/providers/product_provider.dart';
import 'package:cloth_ecommerce_application/screens/product%20details/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import '../../../../../model/product_model.dart';
import '../../../../../widgets/custom_snack_bar.dart';

class CustomListTiles extends StatelessWidget {
  const CustomListTiles({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final products = provider.items;
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: products.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ProductDetailsPage(
                      id: products[index].id,
                      color: products[index].color,
                      description: products[index].description,
                      imageUrl: products[index].imageUrl,
                      name: products[index].name,
                      isLiked: products[index].isLiked,
                      price: products[index].price.toInt(),
                      rating: products[index].rating,
                    ),
              ),
            );
          },
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
                      image: NetworkImage(products[index].imageUrl),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                ///price details
                _priceDetails(size, index: index, products: products[index]),
                _favoriteButton(product: products[index], provider: provider),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _priceDetails(
    Size size, {
    required int index,
    required ProductModel products,
  }) {
    const TextStyle productNameStyle = TextStyle(fontWeight: FontWeight.bold);
    final TextStyle productColorStyle = TextStyle(
      color: Colors.grey.shade400,
      fontSize: 12,
    );
    const TextStyle productPriceStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    );
    return Container(
      padding: const EdgeInsets.only(
        left: 8,
        top: 15,
      ), // make padding inside the container
      height: size.height * 0.15, // same height as outside container
      width:
          size.width *
          0.45, // 1st image contaier had 30 5 and then price detail contain have 45 %
      // color: Colors.pink, --> testing layouts
      child: Column(
        spacing: size.height * 0.001,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(products.name, style: productNameStyle),
          Text(products.color, style: productColorStyle),
          Row(
            // used row for align star rating at the left side
            children: [
              StarRating(
                allowHalfRating: true,
                color: Colors.yellow.shade400,
                starCount: 5,
                rating: 5,
                size: 20,
              ),
            ],
          ),
          Text("${products.price}", style: productPriceStyle),
        ],
      ),
    );
  }

  Widget _favoriteButton({
    required ProductProvider provider,
    required ProductModel product,
  }) {
    return Consumer<ProductProvider>(
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
    );
  }
}
