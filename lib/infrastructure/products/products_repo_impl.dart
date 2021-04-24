import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/failures.dart';
import '../../domain/core/product.dart';
import '../../domain/products/i_products_repo.dart';
import '../../domain/products/products.dart';
import '../core/connection_checker.dart';
import 'products_remote_datasource.dart';

@LazySingleton(as: IProductsRepository)
class ProductsRepositoryImpl implements IProductsRepository {
  final IProductsRemoteDatasource remoteDatasource;
  final INetworkInfo networkInfo;

  ProductsRepositoryImpl({
    @required this.remoteDatasource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Products>> getProducts() async {
    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return left(Failure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      final products = await remoteDatasource.getProducts();
      return right(products);
    } catch (e) {
      return left(Failure(message: Failure.SERVER_FAILURE_MSG));
    }
  }

  @override
  Future<Either<Failure, Product>> createProduct({
    String name,
    double price,
    int discountRate,
    String image,
    String catId,
    String description,
    bool featured,
  }) async {
    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return left(Failure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      final product = await remoteDatasource.createProduct(
        name: name,
        price: price,
        discountRate: discountRate,
        image: image,
        catId: catId,
        description: description,
        featured: featured,
      );

      return right(product);
    } catch (e) {
      return left(Failure(message: Failure.SERVER_FAILURE_MSG));
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct({
    String id,
    String name,
    double price,
    int discountRate,
    String image,
    String catId,
    String description,
    bool featured,
  }) async {
    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return left(Failure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      final product = await remoteDatasource.updateProduct(
        id: id,
        name: name,
        price: price,
        discountRate: discountRate,
        image: image,
        catId: catId,
        description: description,
        featured: featured,
      );

      return right(product);
    } catch (e) {
      return left(Failure(message: Failure.SERVER_FAILURE_MSG));
    }
  }

  @override
  Future<Option<Failure>> deleteProduct({@required String id}) async {
    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return some(Failure(message: Failure.NO_INTERNET_CONNECTION));
    }
    
    try {
      await remoteDatasource.deleteProduct(id: id);
      return none();
    } catch (_) {
      return some(Failure(message: Failure.SERVER_FAILURE_MSG));
    }
  }
}
