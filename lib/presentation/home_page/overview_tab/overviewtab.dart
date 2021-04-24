import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/home_cubit/home_cubit.dart';
import 'overviewtab_failed.dart';
import 'widgets/widgets.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (ctx, state) {
      if (state is HomeInitial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is HomeFailed) {
        return const OverviewTabFailed();
      } else {
        return const MyOverviewTab();
      }
    });
  }
}

class MyOverviewTab extends StatelessWidget {
  const MyOverviewTab();

  @override
  Widget build(BuildContext ctx) {
    final state = ctx.watch<HomeCubit>().state;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const Heading(title: "Our Services"),
          const Menus(),
          const Divider(height: 8),
          const Appointments(),
          const Heading(title: "Most Buyed"),
          if (state is HomeLoaded)
            FeaturedProductsList(state.homeModel.featuredProducts)
          else
            const SizedBox(height: 10),
        ],
      ),
    );
  }
}
