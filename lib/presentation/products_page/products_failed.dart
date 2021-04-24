import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/products_cubit/products_cubit.dart';
import '../../utils/utils.dart';
import '../res/res.dart';

class ProductsFailedPage extends StatelessWidget {
  const ProductsFailedPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Medical Products",
        ),
      ),
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "😱",
              style: AppTheme.failureMessageStyle.copyWith(
                fontSize: 8.percentOf(ctx.screenWidth),
              ),
            ),
            Text(
              (ctx.read<ProductsCubit>().state as ProductsFailed)
                  .failure
                  .message,
              style: AppTheme.failureMessageStyle.copyWith(
                fontSize: 8.percentOf(ctx.screenWidth),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
