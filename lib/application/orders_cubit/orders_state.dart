part of 'orders_cubit.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

class OrdersLoading extends OrdersState {
  const OrdersLoading();
}

class OrdersLoaded extends OrdersState {
  final List<Order> orders;

  const OrdersLoaded({@required this.orders});

  @override
  List<Object> get props => [orders];
}

class OrdersLoadingFailed extends OrdersState {
  final Failure failure;

  const OrdersLoadingFailed(this.failure);

  @override
  List<Object> get props => [failure];
}

class OrderSubmitted extends OrdersState {
  const OrderSubmitted();
}

class OrderSubmitFailed extends OrdersState {
  final Failure failure;

  const OrderSubmitFailed(
    this.failure,
  );

  @override
  List<Object> get props => [failure];
}

class OrdersDeleted extends OrdersState {
  const OrdersDeleted();
}

class OrderDeleteFailed extends OrdersState {
  final Failure failure;

  const OrderDeleteFailed(
    this.failure,
  );

  @override
  List<Object> get props => [failure];
}