import 'package:cloth_ecommerce_application/constants/constants.dart';
import 'package:cloth_ecommerce_application/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            _customcardsOfProduct(size),
            _fashionSale(
              size,
              height: 0.50,
              image: streetCloths,
              text: "Street Cloths",
            ),
            _customcardsOfProduct(size),
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

  Widget _customcardsOfProduct(Size size) {
    final List<String> networkImagesFortesting = [image4, image5, image6];
    return SizedBox(
      height: size.height * 0.5,
      width: size.width * 1,
      child: ListView.builder(
        itemCount: networkImagesFortesting.length,
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
                Container(
                  margin: const EdgeInsets.all(5),
                  height: size.height * 0.30,
                  width: size.width * 0.60,
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
                //price details
                _priceDetails(size),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _insideTheImageWithDiscountAndFavourites() {
    return Align(
      alignment: Alignment.topRight, // Positions at the top-right
      child: Container(
        width: 28, // Smaller background container
        height: 28, // Smaller background container
        margin: EdgeInsets.all(5), // Adds spacing from the edges
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle, // Circular shape
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 4, spreadRadius: 1),
          ],
        ),
        child: Center(
          child: InkWell(
            onTap: () {},
            child: Icon(
              Icons.favorite,
              size: 16, // Smaller icon
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  Widget _priceDetails(Size size) {
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
          ),
          Text(
            "Product name",
            style: TextStyle(color: Colors.grey.shade400, fontSize: 18),
          ),
          const Text(
            "Product Type",
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
                "Rs. 200",
                style: TextStyle(
                  color: Colors.grey.shade400,
                  decoration: TextDecoration.lineThrough,
                  fontSize: 18,
                ),
              ),
              Text(
                'Rs.150',
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
