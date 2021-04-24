import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_app2/presentation/res/res.dart';

import '../../../../application/carts_cubit/carts_cubit.dart';
import '../../../../domain/cart/cart.dart';
import '../../../../infrastructure/core/api_constants.dart';

class CartCard extends StatelessWidget {
  final Cart cart;

  const CartCard({
    Key key,
    this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartsCubit = context.watch<CartsCubit>();

    return Card(
      color: AppTheme.backgroundColor2,
      elevation: 8.0,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                ApiConstants.imageUrl(cart.product.image),
              ),
            ),
            title: Text(cart.product.name),
            subtitle: Text("price : Rs ${cart.product.price}"),
            trailing: Text('Total : ${cart.product.price * cart.quantity}'),
          ),
          const Divider(
            indent: 25,
            endIndent: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  cartsCubit.addItems(cart);
                },
              ),
              Text('${cart.quantity}'),
              IconButton(
                icon: Icon(
                  Icons.remove,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () {
                  cartsCubit.removeItem(cart.product.id);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
