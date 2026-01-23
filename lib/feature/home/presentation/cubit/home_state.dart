part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<DoctorEntity> doctors;
  HomeSuccess({required this.doctors});
}

final class HomeFailure extends HomeState {
  final String error;
  HomeFailure({required this.error});
}

