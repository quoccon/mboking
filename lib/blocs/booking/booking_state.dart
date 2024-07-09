part of 'booking_cubit.dart';

@immutable
sealed class BookingState extends Equatable{}

final class BookingInitial extends BookingState {
  @override
  List<Object?> get props => [];
}

final class BookingSuccess extends BookingState{
  final Booking booking;
  BookingSuccess(this.booking);
  @override
  List<Object?> get props => [booking];
}

final class BookingError extends BookingState{
  final String error;
  BookingError(this.error);
  @override
  List<Object?> get props => [error];
}
