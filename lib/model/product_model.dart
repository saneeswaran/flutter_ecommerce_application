import 'dart:convert';
import '../constants/constants.dart';

class ProductModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final int categoryId;
  final int stock;
  final String imageUrl;
  int quantity;
  final String size;
  final String type;
  final String color;
  double rating;
  bool isLiked;
  final int originalPrice;
  final bool isOnSale;
  final int discountPercentage;
  final DateTime createdAt;
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.imageUrl,
    this.quantity = 1,
    required this.size,
    required this.stock,
    required this.type,
    required this.color,
    required this.rating,
    required this.isLiked,
    required this.originalPrice,
    required this.isOnSale,
    required this.discountPercentage,
    required this.createdAt,
  });

  ProductModel copyWith({int? quantity}) {
    return ProductModel(
      id: id,
      name: name,
      imageUrl: imageUrl,
      price: price,
      quantity: quantity ?? this.quantity,
      categoryId: categoryId,
      color: color,
      stock: stock,
      createdAt: createdAt,
      description: description,
      discountPercentage: discountPercentage,
      isLiked: isLiked,
      isOnSale: isOnSale,
      originalPrice: originalPrice,
      rating: rating,
      size: size,
      type: type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'categoryId': categoryId,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'stock': stock,
      'size': size,
      'type': type,
      'color': color,
      'rating': rating,
      'isLiked': isLiked,
      'originalPrice': originalPrice,
      'isOnSale': isOnSale,
      'discountPercentage': discountPercentage,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      categoryId: map['categoryId'] as int,
      imageUrl: map['imageUrl'] as String,
      quantity: map['quantity'] as int,
      size: map['size'] as String,
      type: map['type'] as String,
      stock: map['stock'] as int,
      color: map['color'] as String,
      rating: map['rating'] as double,
      isLiked: map['isLiked'] as bool,
      originalPrice: map['originalPrice'] as int,
      isOnSale: map['isOnSale'] as bool,
      discountPercentage: map['discountPercentage'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
  static List<ProductModel> sampleProductData = [
    ProductModel(
      id: 0,
      name: "Geto",
      description: "Madddagudu Madhan",
      price: 600,
      categoryId: 2,
      imageUrl: image1,
      stock: 10,
      size: "L",
      type: "Cosplay",
      color: "Black",
      rating: 5.0,
      isLiked: false,
      originalPrice: 1500,
      isOnSale: true,
      discountPercentage: 20,
      createdAt: DateTime.now(),
    ),
    ProductModel(
      id: 1,
      name: "Eren yeager",
      description: "Madddagudu Madhan",
      price: 600,
      categoryId: 2,
      imageUrl: image2,
      stock: 10,
      size: "L",
      type: "Cosplay",
      color: "Black",
      rating: 5.0,
      isLiked: false,
      originalPrice: 1500,
      isOnSale: true,
      discountPercentage: 20,
      createdAt: DateTime.now(),
    ),
    ProductModel(
      id: 2,
      name: "Sakura Haruka",
      description: "Madddagudu Madhan",
      price: 600,
      categoryId: 2,
      imageUrl: image3,
      stock: 10,
      size: "L",
      type: "Cosplay",
      color: "Black",
      rating: 5.0,
      isLiked: false,
      originalPrice: 1500,
      isOnSale: true,
      discountPercentage: 20,
      createdAt: DateTime.now(),
    ),
    ProductModel(
      id: 3,
      name: "Micky",
      description: "Madddagudu Madhan",
      price: 600,
      categoryId: 2,
      imageUrl: image4,
      stock: 10,
      size: "L",
      type: "Cosplay",
      color: "Black",
      rating: 5.0,
      isLiked: false,
      originalPrice: 1500,
      isOnSale: true,
      discountPercentage: 20,
      createdAt: DateTime.now(),
    ),
    ProductModel(
      id: 4,
      name: "Gojo",
      description: "Madddagudu Madhan",
      price: 600,
      categoryId: 2,
      imageUrl: image5,
      stock: 10,
      size: "L",
      type: "Cosplay",
      color: "Black",
      rating: 5.0,
      isLiked: false,
      originalPrice: 1500,
      isOnSale: true,
      discountPercentage: 20,
      createdAt: DateTime.now(),
    ),
    ProductModel(
      id: 5,
      name: "Itachi",
      description: "Madddagudu Madhan",
      price: 600,
      categoryId: 2,
      imageUrl: image6,
      stock: 10,
      size: "L",
      type: "Cosplay",
      color: "Black",
      rating: 5.0,
      isLiked: false,
      originalPrice: 1500,
      isOnSale: true,
      discountPercentage: 20,
      createdAt: DateTime.now(),
    ),
  ];
}
