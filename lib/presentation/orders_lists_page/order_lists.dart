import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/orders_cubit/orders_cubit.dart';
import '../home_page/widgets/widgets.dart';
import 'widgets/item_list.dart';

class OrderListsPage extends StatefulWidget {
  static String routeName = "./orders-list-screen";

  const OrderListsPage();

  @override
  _OrderListsPageState createState() => _OrderListsPageState();
}

class _OrderListsPageState extends State<OrderListsPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>()..fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrdersCubit, OrdersState>(
      listener: (context, state) async {
        if (state is OrderDeleteFailed) {
          await FlushbarHelper.createError(message: "Order Delete Failed")
              .show(context);
        } else if (state is OrdersDeleted) {
          await FlushbarHelper.createSuccess(message: "Order Deleted")
              .show(context);
          Navigator.pop(context);
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Orders"),
          ),
          drawer: const AppDrawer(),
          body: BlocBuilder<OrdersCubit, OrdersState>(
            builder: (context, state) {
              if (state is OrdersLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is OrdersLoaded) {
                return ListView.separated(
                  separatorBuilder: (_, __) => const Divider(
                    thickness: 1.2,
                    color: Colors.grey,
                  ),
                  itemBuilder: (context, index) {
                    return ExpandableItemList(order: state.orders[index]);
                  },
                  itemCount: state.orders.length,
                );
              } else {
                return const Center(
                  child: Text("Something went wrong"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
