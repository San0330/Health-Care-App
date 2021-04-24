part of 'product_cud_cubit.dart';

class ProductCudState extends Equatable {
  const ProductCudState({
    this.isUpdating,
    this.isSaving,
    this.failure,
    this.product,
  });

  final Product product;
  final bool isUpdating;
  final bool isSaving;
  final Option<Failure> failure;

  @override
  List<Object> get props => [product, isUpdating, isSaving, failure];

  ProductCudState copyWith({
    Product product,
    bool isUpdating,
    bool isSaving,
    Option<Failure> failure,
  }) {
    return ProductCudState(
      product: product ?? this.product,
      isUpdating: isUpdating ?? this.isUpdating,
      isSaving: isSaving ?? this.isSaving,
      failure: failure ?? this.failure,
    );
  }

  factory ProductCudState.initial() {
    return ProductCudState(isSaving: false, isUpdating: true, failure: none());
  }
}
