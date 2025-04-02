import 'package:cloth_ecommerce_application/constants/constants.dart';
import 'package:cloth_ecommerce_application/screens/shop%20page/tab%20bar/category/components/custom_grid_tile.dart';
import 'package:cloth_ecommerce_application/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:like_button/like_button.dart';

import 'components/custom_drop_down.dart';

class ProductDetailsPage extends StatefulWidget {
  final String imageUrl;
  final String color;
  final String name;
  final int price;
  final double rating;
  final String description;
  const ProductDetailsPage({
    super.key,
    required this.imageUrl,
    required this.color,
    required this.name,
    required this.price,
    required this.rating,
    required this.description,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  String? selectedDressSize;
  String? selectedDressColor;
  bool isClickedButton = false;
  @override
  Widget build(BuildContext context) {
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
                  _sizeAndColorAndfavourites(),
                  _productDetails(),
                  _description(),

                  //add to cart button
                  SizedBox(
                    height: size.height * 0.07,
                    width: size.width * 1,
                    child: CustomElevatedButton(
                      onPressed: () {},
                      text: "Add to cart",
                    ),
                  ),
                  _alsoLikeSameModel(),
                  SizedBox(
                    height: size.height * 0.40,
                    width: size.width * 1,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: networkImagesFortesting.length,
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

  Row _sizeAndColorAndfavourites() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomDropDown(
          value: selectedDressSize,
          dropDownValues: ['S', 'M', 'L', 'XL', 'XXL'],
          onChanged:
              (value) => setState(() {
                selectedDressSize = value;
              }),
        ),
        CustomDropDown(
          value: selectedDressColor,
          dropDownValues: ['Blue', 'Red', 'Yellow', 'Black'],
          onChanged:
              (value) => setState(() {
                selectedDressColor = value;
              }),
        ),
        LikeButton(
          animationDuration: const Duration(milliseconds: 400),
          isLiked: isClickedButton,
          size: 25,
          circleColor: CircleColor(
            start: Colors.grey.shade400,
            end: Colors.grey.shade400,
          ),
          likeBuilder: (isLiked) {
            isLiked = isClickedButton;
            return null;
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
