import 'package:cached_network_image/cached_network_image.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/carts_cubit/carts_cubit.dart';
import '../../../domain/cart/cart.dart';
import '../../../domain/core/product.dart';
import '../../../infrastructure/core/api_constants.dart';
import '../../core/widgets/discount_tag.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
      child: GridTile(
        header: product.discountRate == 0
            ? const SizedBox()
            : DiscountTag(discountRate: product.discountRate),
        footer: Container(
          color: Colors.white60,
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
                color: Theme.of(context).primaryColor,
                size: 33.0,
              ),
            ),
            title: Text(
              product.name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Rs. ${product.price}',
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.red,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        child: CachedNetworkImage(
          imageUrl: ApiConstants.imageUrl(product.image),
        ),
      ),
    );
  }
}
