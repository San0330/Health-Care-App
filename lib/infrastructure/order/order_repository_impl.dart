import 'package:dartz/dartz.dart' hide Order;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/auth/auth_failures.dart';
import '../../domain/core/failures.dart';
import '../../domain/order/i_orders_repo.dart';
import '../../domain/order/order.dart';
import '../core/connection_checker.dart';

@LazySingleton(as: IOrderRepository)
class OrderRepository implements IOrderRepository {
  final INetworkInfo networkInfo;
  final Dio dio;

  OrderRepository(this.networkInfo, this.dio);

  @override
  Future<Either<Failure, List<Order>>> fetchOrders() async {
    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return left(AuthFailure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      final Response response = await dio.get("/orders");
      final orderData = response.data['data']['orders'] as List<dynamic>;

      final List<Order> orders = [];
      for (final order in orderData) {
        final ord = Order.fromJson(order as Map<String, dynamic>);
        orders.add(ord);
      }

      return right(orders);
    } catch (e) {
      return left(AuthFailure(message: Failure.SERVER_FAILURE_MSG));
    }
  }

  @override
  Future<Option<Failure>> submitOrder(Order order) async {
    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return some(AuthFailure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      await dio.post("/orders", data: order.toJson());

      return none();
    } catch (e) {
      return some(AuthFailure(message: Failure.NO_INTERNET_CONNECTION));
    }
  }

  @override
  Future<Either<Failure, List<Order>>> fetchAllOrders() async {
    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return left(AuthFailure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      final Response response = await dio.get("/orders/get-all");
      final orderData = response.data['data']['orders'] as List<dynamic>;

      final List<Order> orders = [];
      for (final order in orderData) {
        final ord = Order.fromJson(order as Map<String, dynamic>);
        orders.add(ord);
      }

      return right(orders);
    } catch (e) {
      return left(AuthFailure(message: Failure.SERVER_FAILURE_MSG));
    }
  }

  @override
  Future<Either<Failure, List<Order>>> updateStatus(
    String id,
    String status,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return left(AuthFailure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      final Response response =
          await dio.post("/orders/updateStatus/$id", data: {
        'status': status,
      });

      final orderData = response.data['data']['orders'] as List<dynamic>;

      final List<Order> orders = [];
      for (final order in orderData) {
        final ord = Order.fromJson(order as Map<String, dynamic>);
        orders.add(ord);
      }

      return right(orders);
    } catch (e) {
      return left(AuthFailure(message: Failure.SERVER_FAILURE_MSG));
    }
  }

  @override
  Future<Option<Failure>> deleteOrder(String id) async {
    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return some(AuthFailure(message: Failure.NO_INTERNET_CONNECTION));
    }

    try {
      await dio.delete("/orders/$id");      
      return none();
    } catch (e) {
      return some(AuthFailure(message: Failure.SERVER_FAILURE_MSG));
    }
  }
}
