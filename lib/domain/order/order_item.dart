import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';

@JsonSerializable()
class OrderItem {
  @JsonKey(name: 'productId')
  final String id;
  final String name;
  final double price;
  final String image;
  final int quantity;

  const OrderItem({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.image,
    @required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  @override
  String toString() {
    return 'OrderItem(name: $name, price: $price, image: $image, quantity: $quantity)';
  }
}
