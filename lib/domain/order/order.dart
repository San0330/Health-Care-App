import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../auth/user.dart';
import 'order_item.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  final String id;

  @JsonKey(name: 'userid')
  final User user;

  @JsonKey(name: 'products')
  final List<OrderItem> items;

  @JsonKey(includeIfNull: false)
  final String date;

  @JsonKey(includeIfNull: false)
  final String status;

  Order({
    @required this.items,
    this.id,
    this.date,
    this.status,
    this.user,    
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
 
  @override
  String toString() {
    return 'Order(id: $id, user: $user, items: $items, date: $date, status: $status)';
  }
}
