import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/failures.dart';
import '../../domain/home/home_model.dart';
import '../../domain/home/i_home_repository.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final IHomeRepository homeRepository;

  HomeCubit(this.homeRepository) : super(HomeInitial());

  Future loadData() async {
    emit(HomeInitial());

    final homeModelEither =
        await homeRepository.getFeatureProductsWithAppointCount();

    emit(
      homeModelEither.fold(
        (f) => HomeFailed(f),
        (r) => HomeLoaded(r),
      ),
    );
  }

  Future reduceAppointmentCount() async {
    final homeLoadedState = state as HomeLoaded;
    final appointmentCount = homeLoadedState.homeModel.appointmentCount;
    final featuredProducts = [...homeLoadedState.homeModel.featuredProducts];

    if (appointmentCount != 0) {
      final updatedHomeModel = HomeModel(
        featuredProducts: featuredProducts,
        appointmentCount: appointmentCount - 1,
      );
      emit(HomeLoaded(updatedHomeModel));
    }
  }

  Future addAppointmentCount() async {
    final homeLoadedState = state as HomeLoaded;
    final appointmentCount = homeLoadedState.homeModel.appointmentCount;
    final featuredProducts = [...homeLoadedState.homeModel.featuredProducts];

    final updatedHomeModel = HomeModel(
      featuredProducts: featuredProducts,
      appointmentCount: appointmentCount + 1,
    );

    emit(HomeLoaded(updatedHomeModel));
  }
}
