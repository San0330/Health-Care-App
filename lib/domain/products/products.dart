import 'package:flutter/foundation.dart' hide Category;
import 'package:json_annotation/json_annotation.dart';
import '../core/category.dart';
import '../core/product.dart';

part 'products.g.dart';

@JsonSerializable(explicitToJson: true)
class Products {
  @JsonKey(required: true)
  final List<Category> categorys;
  @JsonKey(required: true)
  final List<Product> products;

  Products({
    @required this.categorys,
    @required this.products,
  });

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsToJson(this);

  @override
  String toString() => 'Products(categorys: $categorys, products: $products)';
}
