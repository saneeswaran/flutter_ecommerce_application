import 'package:cloth_ecommerce_application/model/product_model.dart';
import 'package:cloth_ecommerce_application/providers/product_provider.dart';
import 'package:cloth_ecommerce_application/screens/shop%20page/tab%20bar/category/components/custom_grid_tile.dart';
import 'package:cloth_ecommerce_application/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_snack_bar.dart';
import 'components/custom_drop_down.dart';

class ProductDetailsPage extends StatefulWidget {
  final int id;
  final String imageUrl;
  final String color;
  final String name;
  final int price;
  final double rating;
  final String description;
  final bool isLiked;
  const ProductDetailsPage({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.color,
    required this.name,
    required this.price,
    required this.rating,
    required this.description,
    required this.isLiked,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  String? selectedDressSize;
  String? selectedDressColor;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final products = provider.items;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: size.height * 0.02,
          children: [
            // image container
            Container(
              height: size.height * 0.40,
              width: size.width * 1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            //dress size
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: size.height * 0.02,
                children: [
                  _sizeAndColorAndfavourites(product: products[widget.id]),
                  _productDetails(),
                  _description(),
                  //add to cart button
                  SizedBox(
                    height: size.height * 0.07,
                    width: size.width * 1,
                    child: Consumer<ProductProvider>(
                      builder: (context, cart, child) {
                        final isInCart = cart.cart.any(
                          (element) => element.id == widget.id,
                        );
                        return CustomElevatedButton(
                          onPressed: () {
                            if (!isInCart) cart.addToCart(products[widget.id]);
                          },
                          text: "Add to cart",
                        );
                      },
                    ),
                  ),
                  _alsoLikeSameModel(),
                  SizedBox(
                    height: size.height * 0.40,
                    width: size.width * 1,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: size.height * 0.40,
                          width: size.width * 0.50,
                          child: CustomGridTile(index: index),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.1),
                ],
              ),
            ),
            //dress color
          ],
        ),
      ),
    );
  }

  Row _alsoLikeSameModel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "You can also like this",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          "No. of item",
          style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
        ),
      ],
    );
  }

  Row _sizeAndColorAndfavourites({required ProductModel product}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomDropDown(
          text: "Select Size",
          value: selectedDressSize,
          dropDownValues: ['S', 'M', 'L', 'XL', 'XXL'],
          onChanged:
              (value) => setState(() {
                selectedDressSize = value;
              }),
        ),
        CustomDropDown(
          text: "Select Color",
          value: selectedDressColor,
          dropDownValues: ['Blue', 'Red', 'Yellow', 'Black'],
          onChanged:
              (value) => setState(() {
                selectedDressColor = value;
              }),
        ),
        Consumer<ProductProvider>(
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
      ],
    );
  }

  Widget _productDetails() {
    return ListTile(
      title: Text(
        widget.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.color,
            style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
          ),
          Row(
            // to make align star rating at the left side
            children: [
              StarRating(
                color: Colors.yellow.shade400,
                rating: widget.rating,
                allowHalfRating: true,
                size: 20,
              ),
            ],
          ),
        ],
      ),
      trailing: Text(
        '${widget.price}',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Widget _description() {
    return Text(widget.description);
  }
}
