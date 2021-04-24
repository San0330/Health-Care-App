import 'package:flutter/material.dart';

import '../../../domain/core/product.dart';
import 'product_gridtile.dart';

class ProductsGrid extends StatelessWidget {
  final List<Product> _products;

  const ProductsGrid(this._products);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return ProductGridTile(product: product);
      },
    );
  }
}
