import 'package:flutter/material.dart';

class ProductsLoadingPage extends StatelessWidget {
  const ProductsLoadingPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Medical Products",
        ),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
