// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  final String name;
  final String description;
  final double price;
  final double quantity;
  final String category;
  final List<String> images;
  final String? id;

  ProductModel({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
    required this.images,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'category': category,
      'images': images,
      'id': id,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    // return ProductModel(
    //   name: map['name'] as String,
    //   description: map['description'] as String,
    //   price: map['price'] as double,
    //   quantity: map['quantity'] as double,
    //   category: map['category'] as String,
    //   images: List<String>.from((map['images'] as List<String>)),
    //   id: map['_id'],
    // );

    return ProductModel(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
