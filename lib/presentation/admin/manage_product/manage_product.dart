import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/products_cubit/products_cubit.dart';
import '../../../domain/core/product.dart';
import '../../../infrastructure/core/api_constants.dart';
import '../widgets/animated_fab.dart';
import 'add_or_edit_product.dart';

class ManageProduct extends StatefulWidget {
  static String routeName = '/manage-product';

  const ManageProduct();

  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>()..loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Products"),
      ),
      floatingActionButton: const AnimatedFloatingBtn(toshow: AddEditProduct()),
      body: Builder(
        builder: (context) {
          final state = context.watch<ProductsCubit>().state;

          if (state is ProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductsLoaded) {
            final productLoadedState = state;
            final List<Product> products = productLoadedState.products;

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, idx) {
                final Product p = products[idx];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      ApiConstants.imageUrl(p.image),
                    ),
                  ),
                  title: Text(p.name),
                  subtitle: Text("RS. ${p.price}"),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditProduct(
                        product: p,
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is ProductsFailed) {
            return Center(child: Text(state.failure.message));
          } else {
            return const Center(child: Text("Unknown state"));
          }
        },
      ),
    );
  }
}
