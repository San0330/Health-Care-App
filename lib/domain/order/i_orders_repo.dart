import 'package:dartz/dartz.dart' hide Order;

import '../core/failures.dart';
import 'order.dart';

abstract class IOrderRepository {
  Future<Either<Failure, List<Order>>> fetchOrders();
  Future<Option<Failure>> submitOrder(Order order);
  Future<Either<Failure, List<Order>>> fetchAllOrders();
  Future<Option<Failure>> deleteOrder(String id);
  Future<Either<Failure, List<Order>>> updateStatus(String id, String status);
}
