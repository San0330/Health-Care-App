import 'package:flutter/foundation.dart';

import '../core/product.dart';

class Cart {
  final Product product;
  int quantity;

  Cart({
    @required this.product,
    this.quantity = 1,
  });

  @override
  String toString() => 'Cart(product: $product, quantity: $quantity)';
}
