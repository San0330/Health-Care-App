part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final HomeModel homeModel;

  const HomeLoaded(this.homeModel);

  @override
  List<Object> get props => [homeModel];
}

class HomeFailed extends HomeState {
  final Failure failure;

  const HomeFailed(this.failure);
}
