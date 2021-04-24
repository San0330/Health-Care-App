import 'package:cached_network_image/cached_network_image.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/carts_cubit/carts_cubit.dart';
import '../../../../domain/cart/cart.dart';
import '../../../../domain/core/product.dart';
import '../../../../infrastructure/core/api_constants.dart';
import '../../../../utils/utils.dart';
import '../../../core/widgets/discount_tag.dart';
import '../../../res/res.dart';

class FeaturedProductsList extends StatelessWidget {
  final List<Product> _products;

  const FeaturedProductsList(this._products);

  @override
  Widget build(BuildContext context) {
    final horizontalSpacing = 0.018 * MediaQuery.of(context).size.width;

    return SizedBox(
      height: 150,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalSpacing,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: _products.length,
        itemBuilder: (ctx, index) {
          final Product product = _products[index];
          return SizedBox(
            width: ctx.screenWidth / 2,
            height: 200,
            child: GridTile(
              header: product.discountRate == 0
                  ? const SizedBox()
                  : DiscountTag(
                      discountRate: product.discountRate,
                    ),
              footer: Container(
                color: AppTheme.backgroundColor2,
                child: ListTile(
                  trailing: InkWell(
                    onTap: () {
                      context.read<CartsCubit>().addItems(
                            Cart(product: product),
                          );

                      FlushbarHelper.createInformation(
                        message: "${product.name} added to the cart",
                      ).show(context);
                    },
                    child: Icon(
                      Icons.add,
                      color: Theme.of(ctx).primaryColor,
                      size: 33.0,
                    ),
                  ),
                  title: InkWell(
                    onTap: () {},
                    child: Text(
                      product.name,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    'Rs. ${product.price}',
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              child: InkWell(
                onTap: () {},
                child: CachedNetworkImage(
                  imageUrl: ApiConstants.imageUrl(product.image),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
