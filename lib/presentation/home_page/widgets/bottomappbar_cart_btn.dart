import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../application/carts_cubit/carts_cubit.dart';
import '../provider/tab_change_provider.dart';

class BottomAppbarCartBtn extends StatelessWidget {
  const BottomAppbarCartBtn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    final tabChangeProvider = Provider.of<TabChangeProvider>(ctx);
    final _color =
        tabChangeProvider.currentTabIndex == 1 ? Colors.blue : Colors.grey;

    return Expanded(
      child: MaterialButton(
        minWidth: 40,
        onPressed: () => tabChangeProvider.changeTab(1),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart,
                  color: _color,
                ),
                Text(
                  "  Cart",
                  style: TextStyle(
                    color: _color,
                  ),
                ),
              ],
            ),
            const CartAmountBadge(),
          ],
        ),
      ),
    );
  }
}

class CartAmountBadge extends StatelessWidget {
  const CartAmountBadge({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartsCubit, CartsState>(
      builder: (context, state) {
        final itemCount = state.carts.length;
        return itemCount != 0
            ? Positioned(
                right: 0,
                top: 4,
                child: CircleAvatar(
                  backgroundColor: Colors.redAccent.withOpacity(0.8),
                  radius: 7,
                  child: Text(
                    "$itemCount",
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              )
            : const SizedBox();
      },
    );
  }
}
