import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../application/auth_bloc/auth_bloc.dart';
import '../../application/home_cubit/home_cubit.dart';
import '../../application/prescription_cubit/prescribtion_cubit.dart';
import '../res/res.dart';
import 'carts_tab/carts_tab.dart';
import 'overview_tab/overviewtab.dart';
import 'provider/tab_change_provider.dart';
import 'widgets/widgets.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home-page';

  const HomePage();

  @override
  Widget build(BuildContext ctx) {
    ctx.read<HomeCubit>()..loadData();

    return BlocListener<PrescribtionCubit, PrescribtionState>(
      listener: (ctx, state) {
        const duration = Duration(seconds: 2);
        if (state is PrescribtionUploadFailed) {
          FlushbarHelper.createError(
                  message: "Failed to upload", duration: duration)
              .show(ctx);
        } else if (state is PrescribtionUploadSuccess) {
          FlushbarHelper.createSuccess(
                  message: "Prescription uploaded", duration: duration)
              .show(ctx);
        }
      },
      child: BlocListener<HomeCubit, HomeState>(
        listenWhen: (prevState, currentState) =>
            prevState.runtimeType == HomeInitial,
        listener: (ctx, state) {
          if (state is HomeLoaded) {
            final username = (ctx.read<AuthBloc>().state as Authenticated)
                .authenticatedUser
                .name;
            FlushbarHelper.createSuccess(message: "Welcome $username")
                .show(ctx);
          } else if (state is HomeFailed) {
            FlushbarHelper.createError(message: state.failure.message)
                .show(ctx);
          }
        },
        child: ChangeNotifierProvider(
          create: (ctx) => TabChangeProvider(),
          child: _MyHomePage(),
        ),
      ),
    );
  }
}

class _MyHomePage extends StatelessWidget {
  final ktabPages = <Widget>[
    const OverviewTab(),
    const CartsTab(),
  ];

  @override
  Widget build(BuildContext ctx) {
    final tabChangeProvider = Provider.of<TabChangeProvider>(ctx);

    final List<Widget> knavbarButtons = <Widget>[
      const BottomAppbarHomeBtn(),
      const BottomAppbarCartBtn(),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(Strings.appName),
        drawer: const AppDrawer(),
        body: ktabPages[tabChangeProvider.currentTabIndex],
        bottomNavigationBar: BottomAppBar(
          notchMargin: 8,
          shape: const CircularNotchedRectangle(),
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: knavbarButtons.map((e) => e).toList(),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const UploadPrescriptionFAB(),
      ),
    );
  }
}
