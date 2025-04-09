import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloth_ecommerce_application/constants/constants.dart';
import 'package:cloth_ecommerce_application/core/colors.dart';
import 'package:cloth_ecommerce_application/model/product_model.dart';
import 'package:cloth_ecommerce_application/providers/product_provider.dart';
import 'package:cloth_ecommerce_application/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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
    final provider = Provider.of<ProductProvider>(context);
    final cart = provider.cart;
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
        body:
            cart.isEmpty
                ? _isEmptyCart()
                : _bagProducts(size, cart: cart, provider: provider),
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

  Widget _bagProducts(
    Size size, {
    required List cart,
    required ProductProvider provider,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: size.height * 0.70, // list view containing height
          width: size.width * 1,
          color: scaffoldBackgroundColor,
          //list of contents
          child: ListView.builder(
            itemCount: cart.length,
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
                child: _productDetails(
                  size,
                  index: index,
                  cart: cart[index],
                  provider: provider,
                ),
              );
            },
          ),
        ),
        _totalAmountAndCheckOutButton(size, provider: provider),
      ],
    );
  }

  Widget _productDetails(
    Size size, {
    required int index,
    required ProductModel cart,
    required ProductProvider provider,
  }) {
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
              image: CachedNetworkImageProvider(cart.imageUrl),
            ),
          ),
        ),
        _priceDetails(size, cart: cart, index: index, provider: provider),
        _priceWithQuantityAndDelete(
          size,
          provider: provider,
          product: cart,
          index: index,
        ),
      ],
    );
  }

  Widget _priceDetails(
    Size size, {
    required ProductModel cart,
    required int index,
    required ProductProvider provider,
  }) {
    return Container(
      height: size.height * 0.15,
      width: size.width * 0.45,
      padding: const EdgeInsets.all(10),
      child: Column(
        spacing: size.height * 0.01, // make space between widgets
        crossAxisAlignment: CrossAxisAlignment.start, //make alignment at start
        children: [
          Text(
            cart.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            spacing: size.width * 0.05,
            children: [
              _customRichText(text: "Color: ", productDetailText: cart.color),
              _customRichText(text: "Size: ", productDetailText: cart.size),
            ],
          ),
          _quantityCounter(size, cart: cart, provider: provider),
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

  Widget _quantityCounter(
    Size size, {
    required ProductModel cart,
    required ProductProvider provider,
  }) {
    return Row(
      spacing: size.width * 0.03,
      children: [
        _quantityContainer(
          size,
          icon: Icons.remove,
          onPressed: () {
            provider.decreaseQuanitity(cart.id);
          },
        ),
        Text(
          '${cart.quantity}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        _quantityContainer(
          size,
          icon: Icons.add,
          onPressed: () {
            provider.increseQuanitity(cart.id, cart.stock);
          },
        ),
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

  Widget _totalAmountAndCheckOutButton(
    Size size, {
    required ProductProvider provider,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: size.height * 0.19,
      width: size.width * 1,
      child: _totalAmount(size, provider: provider),
    );
  }

  Widget _totalAmount(Size size, {required ProductProvider provider}) {
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
              provider.totalPrice.toString(),
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

  Widget _priceWithQuantityAndDelete(
    Size size, {
    required ProductProvider provider,
    required ProductModel product,
    required int index,
  }) {
    final price = provider.cart[index].price * provider.cart[index].quantity;
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
              onPressed: () {
                provider.removeCart(product.id);
              },
              icon: Icon(Icons.delete, color: buttonColor),
              tooltip: "Remove from cart",
              iconSize: 20,
            ),
          ),
          Text(price.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _isEmptyCart() {
    return Center(child: SvgPicture.asset(noCart, fit: BoxFit.cover));
  }
}
