import 'dart:convert';

import 'package:cloth_ecommerce_application/constants/constants.dart';

class ProductModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final int categoryId;
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
    required this.quantity,
    required this.size,
    required this.type,
    required this.color,
    required this.rating,
    required this.originalPrice,
    required this.isOnSale,
    this.isLiked = false,
    required this.discountPercentage,
    required this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0, // Default to 0 if null
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      categoryId: json['category_id'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      quantity: json['stock_quantity'] ?? 0,
      size: json['size'] ?? '',
      type: json['type'] ?? '',
      color: json['color'] ?? '',
      isLiked: json['is_liked'] ?? false,
      rating:
          double.tryParse(json['rating'].toString()) ??
          0.0, // Handle rating safely
      originalPrice:
          int.tryParse(json['original_price'].toString()) ??
          0, // Handle price safely
      isOnSale: json['is_on_sale'] == 1,
      discountPercentage: json['discount_percentage'] ?? 0,
      createdAt:
          json['created_at'] != null
              ? DateTime.tryParse(json['created_at']) ?? DateTime.now()
              : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category_id': categoryId,
      'image_url': imageUrl,
      'stock_quantity': quantity,
      'size': size,
      'type': type,
      'color': color,
      'rating': rating,
      'original_price': originalPrice,
      'is_on_sale': isOnSale ? 1 : 0,
      'discount_percentage': discountPercentage,
      'created_at': createdAt.toIso8601String(),
    };
  }

  static List<ProductModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }

  static String toJsonList(List<ProductModel> products) {
    return jsonEncode(products.map((product) => product.toJson()).toList());
  }
}

List<Map<String, dynamic>> jsonModelData = [
  {
    "id": 1,
    "name": "Geto",
    "description": "Stylish party wear dress",
    "price": 600,
    "category_id": 2,
    "image_url": image1,
    "quantity": 10,
    "size": "M",
    "rating": 4.5,
    "type": "Cosplay",
    'originalPrice': 1000,
    "color": "Red",
    "is_on_sale": 1,
    "discount_percentage": 20,
    "created_at": "2025-04-01T12:00:00Z",
  },
  {
    "id": 2,
    "name": "Eren Yeager",
    "description": "Stylish party wear dress",
    "price": 600,
    "category_id": 2,
    "image_url": image2,
    "quantity": 10,
    "size": "M",
    "rating": 4.5,
    "type": "Cosplay",
    'originalPrice': 1000,
    "color": "Red",
    "is_on_sale": 1,
    "discount_percentage": 20,
    "created_at": "2025-04-01T12:00:00Z",
  },
  {
    "id": 3,
    "name": "Sakura Haruka",
    "description": "Stylish party wear dress",
    "price": 600,
    "category_id": 2,
    "image_url": image3,
    "quantity": 10,
    "size": "M",
    "rating": 4.5,
    "type": "Cosplay",
    'originalPrice': 1000,
    "color": "Red",
    "is_on_sale": 1,
    "discount_percentage": 20,
    "created_at": "2025-04-01T12:00:00Z",
  },
  {
    "id": 4,
    "name": "Micky",
    "description": "Stylish party wear dress",
    "price": 600,
    "category_id": 2,
    "image_url": image4,
    "quantity": 10,
    "size": "M",
    "rating": 4.5,
    "type": "Cosplay",
    'originalPrice': 1000,
    "color": "Red",
    "is_on_sale": 1,
    "discount_percentage": 20,
    "created_at": "2025-04-01T12:00:00Z",
  },
  {
    "id": 5,
    "name": "Gojo",
    "description": "Stylish party wear dress",
    "price": 600,
    "category_id": 2,
    "image_url": image5,
    "quantity": 10,
    "size": "M",
    "rating": 4.5,
    "type": "Cosplay",
    'originalPrice': 1000,
    "color": "Red",
    "is_on_sale": 1,
    "discount_percentage": 20,
    "created_at": "2025-04-01T12:00:00Z",
  },
  {
    "id": 6,
    "name": "Itachi",
    "description": "Stylish party wear dress",
    "price": 600,
    "category_id": 2,
    "image_url": image6,
    "quantity": 10,
    "size": "M",
    "rating": 4.5,
    "type": "Cosplay",
    'originalPrice': "1000",
    "color": "Red",
    "is_on_sale": 1,
    "discount_percentage": 20,
    "created_at": "2025-04-01T12:00:00Z",
  },
];
