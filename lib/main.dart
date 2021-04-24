import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import 'application/appointment_actions_cubit/appointment_action_cubit.dart';
import 'application/auth_bloc/auth_bloc.dart';
import 'application/carts_cubit/carts_cubit.dart';
import 'application/home_cubit/home_cubit.dart';
import 'application/orders_cubit/orders_cubit.dart';
import 'application/prescription_cubit/prescribtion_cubit.dart';
import 'application/products_cubit/products_cubit.dart';
import 'application/profile_cubit/profile_cubit.dart';
import 'application/survey_cubit/survey_cubit.dart';
import 'application/survey_cud_cubit/survey_cud_cubit.dart';
import 'infrastructure/core/api_constants.dart';
import 'injection.dart';
import 'presentation/core/app_widget.dart';
import 'utils/logger.dart';

class MyBlocObserver extends BlocObserver {
  final logger = getLogger("MyBlocObserver");

  @override
  void onEvent(Bloc bloc, Object event) {
    logger.i(event);
    super.onEvent(bloc, event);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    logger.i(change);
    super.onChange(cubit, change);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    logger.e('$error, $stackTrace');
    super.onError(cubit, error, stackTrace);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleMap.init(ApiConstants.googleMapsApi);
  await configureInjection(Environment.prod);
  Bloc.observer = MyBlocObserver();

  Logger.level = Level.verbose;

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<AuthBloc>()),
          BlocProvider(create: (_) => getIt<CartsCubit>()),
          BlocProvider(create: (_) => getIt<OrdersCubit>()),
          BlocProvider(create: (_) => getIt<ProfileCubit>()),
          BlocProvider(create: (_) => getIt<HomeCubit>()),
          BlocProvider(create: (_) => getIt<AppointmentActionCubit>()),
          BlocProvider(create: (_) => getIt<ProductsCubit>()),
          BlocProvider(create: (_) => getIt<AppointmentActionCubit>()),
          BlocProvider(create: (_) => getIt<SurveyCudCubit>()),
          BlocProvider(create: (_) => getIt<SurveyCubit>()),
          BlocProvider(create: (_) => getIt<PrescribtionCubit>()),
        ],
        child: App(),
      ),
    ),
  );
}
