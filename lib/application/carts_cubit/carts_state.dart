part of 'carts_cubit.dart';

class CartsState extends Equatable {
  const CartsState(
    this.carts,
  );

  final List<Cart> carts;

  @override
  List<Object> get props => [carts];

  factory CartsState.initial() {
    return const CartsState([]);
  }
}
