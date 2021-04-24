import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/home_cubit/home_cubit.dart';
import '../../../utils/utils.dart';
import '../../res/res.dart';

class OverviewTabFailed extends StatelessWidget {
  const OverviewTabFailed({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    final state = ctx.watch<HomeCubit>().state as HomeFailed;

    return Align(
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
            state.failure.message,
            style: AppTheme.failureMessageStyle.copyWith(
              fontSize: 8.percentOf(ctx.screenWidth),
            ),
          ),
        ],
      ),
    );
  }
}
