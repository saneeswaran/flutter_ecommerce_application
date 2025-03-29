// ignore_for_file: public_member_api_docs, sort_constructors_first
class FakeModel {
  final String name;
  final String color;
  final int price;
  final String type;
  final int originalPrice;
  final double rating;
  FakeModel({
    required this.name,
    required this.color,
    required this.price,
    required this.rating,
    required this.type,
    required this.originalPrice,
  });
}

List<FakeModel> testingfakeModel = [
  FakeModel(
    name: "Geto Cosplay",
    color: "Black",
    price: 500,
    rating: 5.0,
    type: "Cosplay",
    originalPrice: 1000,
  ),
  FakeModel(
    name: "Eren Yeager Cosplay",
    color: "Grey and White",
    price: 500,
    rating: 5.0,
    type: "Cosplay",
    originalPrice: 1000,
  ),
  FakeModel(
    name: "Sakura Haruka Cosplay",
    color: "Green and Black",
    price: 500,
    rating: 5.0,
    type: "Cosplay",
    originalPrice: 1000,
  ),
  FakeModel(
    name: "Micky Cosplay",
    color: "Black and White",
    price: 500,
    rating: 5.0,
    type: "cosplay",
    originalPrice: 1000,
  ),
  FakeModel(
    name: "Gojo Cosplay",
    color: "Black",
    price: 700,
    rating: 5.0,
    type: "Cosplay",
    originalPrice: 1000,
  ),
  FakeModel(
    name: "Itachi Cosplay",
    color: "Black and Red",
    price: 500,
    rating: 5.0,
    type: "Cosplay",
    originalPrice: 1000,
  ),
];
