import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../application/carts_cubit/carts_cubit.dart';
import '../../../application/orders_cubit/orders_cubit.dart';
import '../../../application/profile_cubit/profile_cubit.dart';
import 'widgets/cartcard.dart';

class CartsTab extends StatelessWidget {
  const CartsTab();

  @override
  Widget build(BuildContext context) {
    final cartsCubit = context.watch<CartsCubit>();
    final cartsState = cartsCubit.state;

    return BlocListener<OrdersCubit, OrdersState>(
      listener: (context, state) {
        if (state is OrderSubmitted) {
          FlushbarHelper.createSuccess(message: "Your order is submitted").show(context);
          cartsCubit.clearCart();
        } else if (state is OrderSubmitFailed) {
          FlushbarHelper.createError(message: "Unable to submit your order !").show(context);
        }
      },
      child: cartsState.carts.isEmpty
          ? Container(
              padding: const EdgeInsets.all(20.0),
              child: const Center(
                child: Text(
                  "Your cart is empty.",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartsState.carts.length,
                    itemBuilder: (context, index) {
                      return CartCard(cart: cartsState.carts[index]);
                    },
                  ),
                ),
                GrandTotalWithSubmitButton(),
              ],
            ),
    );
  }
}

class GrandTotalWithSubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartsCubit = context.watch<CartsCubit>();
    final price = cartsCubit.getTotalPrice();

    return Container(
      decoration: const BoxDecoration(color: Colors.black38),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Total : Rs $price",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          FloatingActionButton.extended(
            heroTag: 'submit_button',
            icon: const Icon(FontAwesomeIcons.save),
            label: Text(
              "Submit".toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              final cart = cartsCubit.state.carts;

              Future.wait([
                context.read<ProfileCubit>().updateLocation(),
                context.read<OrdersCubit>().submitOrders(cart),
              ]);
            },
          ),
        ],
      ),
    );
  }
}
