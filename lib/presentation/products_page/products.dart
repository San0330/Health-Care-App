import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/products_cubit/products_cubit.dart';
import 'products_failed.dart';
import 'products_loading.dart';
import 'widgets/products_grid.dart';

class ProductsPage extends StatelessWidget {
  static String routeName = '/products-page';

  const ProductsPage();

  @override
  Widget build(BuildContext context) {
    final productsCubit = context.watch<ProductsCubit>();
    final state = productsCubit.state;

    if (state is ProductsLoading) {
      productsCubit.loadData();
      return const ProductsLoadingPage();
    } else if (state is ProductsFailed) {
      return const ProductsFailedPage();
    } else if (state is ProductsLoaded) {
      return const MyProductsPage();
    } else {
      return const SizedBox();
    }
  }
}

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({
    Key key,
  }) : super(key: key);

  @override
  _MyProductsPageState createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  ProductsLoaded state;
  List<Tab> tabs;

  @override
  void initState() {
    state = context.read<ProductsCubit>().state as ProductsLoaded;
    tabs = state.categorys
        .map(
          (category) => Tab(
            child: Text(category.name),
          ),
        )
        .toList();

    _tabController = TabController(vsync: this, length: tabs.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Medical Products",
          ),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white54,
            indicatorWeight: 3.0,
            isScrollable: true,
            tabs: tabs,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
          child: TabBarView(
            controller: _tabController,
            children: state.categorys
                .map(
                  (e) => ProductsGrid(
                    state.products
                        .where(
                          (element) => element.category.id == e.id,
                        )
                        .toList(),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
