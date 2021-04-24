import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/products_cubit/products_cubit.dart';
import '../../../infrastructure/core/api_constants.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is! ProductsLoaded) {
          context.watch<ProductsCubit>().loadData();
          return const Center(child: CircularProgressIndicator());
        } else {
          final loadedState = state as ProductsLoaded;

          var searchProducts = loadedState.products
              .where((element) =>
                  element.name.toLowerCase().startsWith(query.toLowerCase()))
              .toList();

          if (query.isEmpty) {
            searchProducts = [];
          }

          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    ApiConstants.imageUrl(searchProducts[index].image),
                  ),
                ),
                title: Text(searchProducts[index].name),
                subtitle: Text(searchProducts[index].category.name),
                trailing: Text(searchProducts[index].price.toString()),
                onTap: () {},
              );
            },
            itemCount: searchProducts.length,
          );
        }
      },
    );
  }
}
