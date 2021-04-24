import 'package:flutter/foundation.dart' hide Category;
import 'package:json_annotation/json_annotation.dart';

import 'category.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product {
  @JsonKey(required: true, name: '_id')
  final String id;
  @JsonKey(required: true, name: 'title')
  final String name;
  @JsonKey(required: true)
  final double price;
  @JsonKey(required: true)
  final int discountRate;
  @JsonKey(nullable: true)
  String image;
  final String description;
  final bool featured;
  @JsonKey(required: true)
  final Category category;

  Product({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.category,
    @required this.description,
    @required this.featured,
    this.image,
    this.discountRate = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, discountRate: $discountRate, image: $image, description: $description, featured: $featured, category: $category)';
  }
}
