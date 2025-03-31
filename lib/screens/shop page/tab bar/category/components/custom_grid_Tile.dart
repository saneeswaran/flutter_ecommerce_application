import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:like_button/like_button.dart';

import '../../../../../constants/constants.dart';
import '../../../../../model/fake_model.dart';
import '../../../../product details/product_details_page.dart';

class CustomGridTile extends StatelessWidget {
  final int index;
  const CustomGridTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(child: _customcardsOfProduct(size, context, index: index));
  }

  Widget _customcardsOfProduct(
    Size size,
    BuildContext context, {
    required int index,
  }) {
    final List<String> networkImagesFortesting = [
      image1,
      image2,
      image3,
      image4,
      image5,
      image6,
    ];
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
                              imageUrl: networkImagesFortesting[index],
                              name: testingfakeModel[index].name,
                              color: testingfakeModel[index].color,
                              price: testingfakeModel[index].price,
                              rating: testingfakeModel[index].rating,
                              description: testingfakeModel[index].description,
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
                        image: NetworkImage(networkImagesFortesting[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                    //inside the image content
                    child: _insideTheImageWithDiscountAndFavourites(),
                  ),
                ),
                //price details
                _priceDetails(size, context, index: index),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _insideTheImageWithDiscountAndFavourites() {
    bool isClickedButton = false;
    return Align(
      alignment: Alignment.topRight, // Positions at the top-right
      child: Container(
        width: 28, // Smaller background container
        height: 28, // Smaller background container
        margin: EdgeInsets.all(5), // Adds spacing from the edges
        child: LikeButton(
          animationDuration: const Duration(milliseconds: 400),
          isLiked: isClickedButton,
          size: 20,
          circleColor: CircleColor(
            start: Colors.grey.shade400,
            end: Colors.grey.shade400,
          ),
          likeBuilder: (isLiked) {
            isLiked = isClickedButton;
            return null;
          },
        ),
      ),
    );
  }

  Widget _priceDetails(Size size, BuildContext context, {required int index}) {
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
          Text(
            testingfakeModel[index].name,
            style: TextStyle(color: Colors.grey.shade400),
          ),
          Text(
            testingfakeModel[index].type,
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
                "${testingfakeModel[index].originalPrice}",
                style: TextStyle(
                  color: Colors.grey.shade400,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Text(
                '${testingfakeModel[index].price}',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
