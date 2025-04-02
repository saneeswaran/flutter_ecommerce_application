import 'package:cloth_ecommerce_application/constants/constants.dart';
import 'package:cloth_ecommerce_application/core/colors.dart';
import 'package:cloth_ecommerce_application/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class BagPage extends StatefulWidget {
  const BagPage({super.key});

  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        //hide textfield when tapped somewhere
        setState(() {
          isSearching = false;
        });
      },
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        appBar: _appBar(),
        body: _bagProducts(size),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      centerTitle: true,
      title: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder:
            (child, animation) =>
                FadeTransition(opacity: animation, child: child),
        child:
            isSearching
                ? SizedBox(
                  key: const ValueKey(1),
                  width: double.infinity,
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Search products...",
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            isSearching = false;
                            _searchController.clear();
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                )
                : const Text(
                  "Bag",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isSearching = true;
            });
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  Widget _bagProducts(Size size) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: size.height * 0.70, // list view containing height
          width: size.width * 1,
          color: scaffoldBackgroundColor,
          //list of contents
          child: ListView.builder(
            itemCount: 4,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(8),
                height: size.height * 0.15, // container size
                width: size.width * 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: _productDetails(size, index: index),
              );
            },
          ),
        ),
        _totalAmountAndCheckOutButton(size),
      ],
    );
  }

  Widget _productDetails(Size size, {required int index}) {
    return Row(
      children: [
        //image container
        Container(
          height:
              size.height *
              0.15, // outside and the image container heights are same
          width: size.width * 0.30,
          //image
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(networkImagesFortesting[index]),
            ),
          ),
        ),
        _priceDetails(size),
        _priceWithQuantityAndDelete(size),
      ],
    );
  }

  Widget _priceDetails(Size size) {
    return Container(
      height: size.height * 0.15,
      width: size.width * 0.45,
      padding: const EdgeInsets.all(10),
      child: Column(
        spacing: size.height * 0.01, // make space between widgets
        crossAxisAlignment: CrossAxisAlignment.start, //make alignment at start
        children: [
          Text(
            "Item name",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            spacing: size.width * 0.05,
            children: [
              _customRichText(text: "Color: ", productDetailText: "Black"),
              _customRichText(text: "Size: ", productDetailText: "L"),
            ],
          ),
          _quantityCounter(size),
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

  Widget _quantityCounter(Size size) {
    return Row(
      spacing: size.width * 0.03,
      children: [
        _quantityContainer(size, icon: Icons.remove, onPressed: () {}),
        Text("1", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        _quantityContainer(size, icon: Icons.add, onPressed: () {}),
      ],
    );
  }

  Widget _quantityContainer(
    Size size, {
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    return Container(
      height: size.height * 0.045, //size of quantity container
      width: size.width * 0.09, // size of quantity container
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            offset: Offset(-1, 1),
            color: Colors.grey.shade200,
            blurRadius: 3,
          ),
          BoxShadow(offset: Offset(1, -1), color: Colors.white, blurRadius: 3),
        ],
      ),
      child: Center(
        child: IconButton(onPressed: onPressed, icon: Icon(icon), iconSize: 20),
      ),
    );
  }

  Widget _totalAmountAndCheckOutButton(Size size) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: size.height * 0.19,
      width: size.width * 1,
      child: _totalAmount(size),
    );
  }

  Widget _totalAmount(Size size) {
    return Column(
      spacing: size.height * 0.01,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Amount :',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
            ),
            Text(
              "500",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.06,
          width: size.width * 1,
          child: CustomElevatedButton(onPressed: () {}, text: "CHECK OUT"),
        ),
      ],
    );
  }

  Widget _priceWithQuantityAndDelete(Size size) {
    return SizedBox(
      height: size.height * 0.15,
      width: size.width * 0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: size.width * 0.09,
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete, color: buttonColor),
              tooltip: "Remove from cart",
              iconSize: 20,
            ),
          ),
          Text("500", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
