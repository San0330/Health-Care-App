import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/failures.dart';
import '../../domain/core/product.dart';
import '../../domain/products/i_products_repo.dart';

part 'product_cud_state.dart';

@injectable
class ProductCudCubit extends Cubit<ProductCudState> {
  final IProductsRepository repository;

  ProductCudCubit(this.repository) : super(const ProductCudState());

  Future createProduct({
    String name,
    double price,
    int discountRate,
    String image,
    String catId,
    String description,
    bool featured,
  }) async {
    emit(state.copyWith(isSaving: true, isUpdating: false, failure: none()));

    final productEither = await repository.createProduct(
      name: name,
      price: price,
      discountRate: discountRate,
      image: image,
      catId: catId,
      description: description,
      featured: featured,
    );

    productEither.fold(
      (f) => emit(
        state.copyWith(isSaving: false, failure: some(f)),
      ),
      (product) => emit(
        state.copyWith(
          isSaving: false,
          failure: none(),
          product: product,
        ),
      ),
    );
  }

  Future updateProduct({
    String id,
    String name,
    double price,
    int discountRate,
    String image,
    String catId,
    String description,
    bool featured,
  }) async {
    emit(state.copyWith(isSaving: true, isUpdating: true, failure: none()));

    final productEither = await repository.updateProduct(
      id: id,
      name: name,
      price: price,
      discountRate: discountRate,
      image: image,
      catId: catId,
      description: description,
      featured: featured,
    );

    productEither.fold(
      (f) => emit(state.copyWith(isSaving: false, failure: some(f))),
      (product) => emit(
        state.copyWith(
          isSaving: false,
          failure: none(),
          product: product,
        ),
      ),
    );
  }

  Future deleteProduct(String id) async {
    emit(state.copyWith(isSaving: true, isUpdating: true, failure: none()));

    final deleteOptions = await repository.deleteProduct(id: id);

    deleteOptions.fold(
      () => emit(
          state.copyWith(isSaving: true, isUpdating: true, failure: none())),
      (a) => emit(
          state.copyWith(isSaving: true, isUpdating: true, failure: some(a))),
    );
  }
}
