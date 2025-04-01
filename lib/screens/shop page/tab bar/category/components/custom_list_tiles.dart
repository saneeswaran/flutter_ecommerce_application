import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:like_button/like_button.dart';

import '../../../../../constants/constants.dart';
import '../../../../../model/fake_model.dart';

class CustomListTiles extends StatelessWidget {
  const CustomListTiles({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> networkImagesFortesting = [
      image1,
      image2,
      image3,
      image4,
      image5,
      image6,
    ];
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: networkImagesFortesting.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
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

              ///price details
              _priceDetails(size, index: index),
              _favoriteButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _priceDetails(Size size, {required int index}) {
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
          Text(testingfakeModel[index].name, style: productNameStyle),
          Text(testingfakeModel[index].color, style: productColorStyle),
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
          Text("${testingfakeModel[index].price}", style: productPriceStyle),
        ],
      ),
    );
  }

  Widget _favoriteButton() {
    bool isClickedButton = false;
    return LikeButton(
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
    );
  }
}
