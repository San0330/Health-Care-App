import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../core/failures.dart';
import '../core/product.dart';
import 'products.dart';

abstract class IProductsRepository {
  Future<Either<Failure, Products>> getProducts();
  Future<Either<Failure, Product>> createProduct({
    String name,
    double price,
    int discountRate,
    String image,
    String catId,
    String description,
    bool featured,
  });

  Future<Either<Failure, Product>> updateProduct({
    String id,
    String name,
    double price,
    int discountRate,
    String image,
    String catId,
    String description,
    bool featured,
  });

  Future<Option<Failure>> deleteProduct({
    @required String id,
  });
}
