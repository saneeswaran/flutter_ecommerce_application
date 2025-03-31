import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  final String imageUrl;
  const ProductDetailsPage({super.key, required this.imageUrl});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Hero(
        tag: widget.imageUrl,
        child: Container(
          height: size.height * 0.40,

          width: size.width * 1,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
