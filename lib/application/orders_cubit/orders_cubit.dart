import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/cart/cart.dart';
import '../../domain/core/failures.dart';
import '../../domain/order/i_orders_repo.dart';
import '../../domain/order/order.dart';
import '../../domain/order/order_item.dart';

part 'orders_state.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.orderRepository) : super(const OrdersLoading());

  IOrderRepository orderRepository;

  Future fetchOrders() async {
    emit(const OrdersLoading());
    final orderFailureOrEither = await orderRepository.fetchOrders();

    orderFailureOrEither.fold(
      (f) => emit(OrdersLoadingFailed(f)),
      (r) => emit(OrdersLoaded(orders: r)),
    );
  }

  Future deleteOrder(String id) async {
    emit(const OrdersLoading());
    final orderFailureOrEither = await orderRepository.deleteOrder(id);

    orderFailureOrEither.fold(
      () => emit(const OrdersDeleted()),
      (f) => emit(OrderDeleteFailed(f)),
    );
  }

  Future fetchAllOrders() async {
    emit(const OrdersLoading());
    final orderFailureOrEither = await orderRepository.fetchAllOrders();

    orderFailureOrEither.fold(
      (f) => emit(OrdersLoadingFailed(f)),
      (r) => emit(OrdersLoaded(orders: r)),
    );
  }

  Future submitOrders(List<Cart> cart) async {
    final Order order = _convertCartItemsToOrders(cart);
    final orderFailureOption = await orderRepository.submitOrder(order);

    orderFailureOption.fold(
      () => emit(const OrderSubmitted()),
      (f) => emit(OrderSubmitFailed(f)),
    );
  }

  Future updateStatus(String id, String status) async {
    emit(const OrdersLoading());
    final orderFailureOrEither = await orderRepository.updateStatus(id,status);

    orderFailureOrEither.fold(
      (f) => emit(OrdersLoadingFailed(f)),
      (r) => emit(OrdersLoaded(orders: r)),
    );
  }

  Order _convertCartItemsToOrders(List<Cart> cart) {
    final List<OrderItem> items = [];

    for (final item in cart) {
      items.add(
        OrderItem(
          id: item.product.id,
          name: item.product.name,
          image: item.product.image,
          price: item.product.price,
          quantity: item.quantity,
        ),
      );
    }
    final order = Order(items: items);
    return order;
  }
}
