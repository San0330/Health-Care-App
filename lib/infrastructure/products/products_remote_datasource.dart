import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/product.dart';
import '../../domain/products/products.dart';
import '../../utils/logger.dart';

abstract class IProductsRemoteDatasource {
  Future<Products> getProducts();
  Future<Product> createProduct({
    String name,
    double price,
    int discountRate,
    String image,
    String catId,
    String description,
    bool featured,
  });
  Future<Product> updateProduct({
    String id,
    String name,
    double price,
    int discountRate,
    String image,
    String catId,
    String description,
    bool featured,
  });
  Future deleteProduct({
    @required String id,
  });
}

@LazySingleton(as: IProductsRemoteDatasource)
class ProductsRemoteDatasourceImpl implements IProductsRemoteDatasource {
  final logger = getLogger("ProductsRemoteDatasourceImpl");

  final Dio dio;

  ProductsRemoteDatasourceImpl(this.dio);

  @override
  Future<Products> getProducts() async {
    try {
      final response = await dio.get(
        "/view/products",
      );

      final products = response.data["data"] as Map<String, dynamic>;

      logger.i(products);

      final productsModel = Products.fromJson(products);

      logger.i(productsModel);

      return productsModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Product> createProduct({
    String name,
    double price,
    int discountRate,
    String image,
    String catId,
    String description,
    bool featured,
  }) async {
    try {
      MultipartFile imageFile;
      if (image != null) {
        final ext = image.split('.').last;
        imageFile = await MultipartFile.fromFile(
          image,
          contentType: MediaType("image", ext),
        );
      }

      final formData = FormData.fromMap({
        "image": imageFile,
        "title": name,
        "price": price,
        "discountRate": discountRate,
        "category": catId,
        "description": description,
        "featured": featured,
      });

      final response = await dio.post("/products", data: formData);
      final products = response.data["data"] as Map<String, dynamic>;
      final productModel = Product.fromJson(products);
      return productModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Product> updateProduct({
    String id,
    String name,
    double price,
    int discountRate,
    String image,
    String catId,
    String description,
    bool featured,
  }) async {
    try {
      MultipartFile imageFile;
      if (image != null) {
        final ext = image.split('.').last;
        imageFile = await MultipartFile.fromFile(
          image,
          contentType: MediaType("image", ext),
        );
      }

      final formData = FormData.fromMap({
        "image": imageFile,
        "title": name,
        "price": price,
        "discountRate": discountRate,
        "category": catId,
        "description": description,
        "featured": featured,
      });

      final response = await dio.patch("/products/$id", data: formData);
      final products = response.data["data"] as Map<String, dynamic>;
      final productModel = Product.fromJson(products);
      return productModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future deleteProduct({String id}) async {
    try {
      await dio.delete("/products/$id");
    } catch (e) {
      rethrow;
    }
  }
}
