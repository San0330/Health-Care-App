import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/failures.dart';
import '../../domain/products/i_products_repo.dart';
import '../../domain/core/product.dart';
import '../../domain/products/products.dart';
import '../../domain/core/category.dart';

part 'products_state.dart';

@injectable
class ProductsCubit extends Cubit<ProductsState> {
  final IProductsRepository repository;

  ProductsCubit(
    this.repository,
  ) : super(ProductsLoading());

  Future loadData() async {
    emit(ProductsLoading());

    final failureOrProducts = await repository.getProducts();

    failureOrProducts.fold(
      (Failure f) => emit(ProductsFailed(f)),
      (Products r) => emit(ProductsLoaded(
        r.products,
        r.categorys,
      )),
    );
  }  
}
