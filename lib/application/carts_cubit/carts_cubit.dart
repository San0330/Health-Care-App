import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/cart/cart.dart';

part 'carts_state.dart';

@injectable
class CartsCubit extends Cubit<CartsState> {
  CartsCubit() : super(CartsState.initial());

  void clearItems() {
    emit(CartsState.initial());
  }

  void addItems(Cart c) {
    final carts = [...state.carts];
    final index = carts.indexWhere((x) => x.product.id == c.product.id);

    if (index == -1) {
      carts.add(c);
    } else {
      carts[index] = Cart(
        product: carts[index].product,
        quantity: carts[index].quantity + 1,
      );
    }

    emit(CartsState(carts));
  }

  void removeItem(String pid) {
    final carts = [...state.carts];
    final index = carts.indexWhere((x) => x.product.id == pid);

    final quantity = carts[index].quantity;

    if (quantity > 1) {
      carts[index] = Cart(
        product: carts[index].product,
        quantity: quantity - 1,
      );
    } else {
      carts.removeAt(index);
    }

    emit(CartsState(carts));
  }

  double getTotalPrice() {
    final double totalPrice = state.carts.fold(
      0,
      (init, x) => init + x.product.price * x.quantity,
    );
    return totalPrice;
  }

  void clearCart() {
    emit(CartsState.initial());
  }
}
