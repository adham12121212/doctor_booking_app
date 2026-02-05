part of 'booked_cubit.dart';

@immutable
sealed class BookedState {}

final class BookedInitial extends BookedState {}

final class BookedLoading extends BookedState {}

final class BookedSuccess extends BookedState {
  final List<BookedEntity> booked;
  BookedSuccess({required this.booked});
}

final class BookedError extends BookedState {
  final String message;
  BookedError({required this.message});
}
