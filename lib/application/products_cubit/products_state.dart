part of 'products_cubit.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;
  final List<Category> categorys;

  const ProductsLoaded(
    this.products,
    this.categorys,
  );

  @override
  List<Object> get props => [products];
}

class ProductsFailed extends ProductsState {
  final Failure failure;

  const ProductsFailed(this.failure);

  @override
  List<Object> get props => [failure];
}
