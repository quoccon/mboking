import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mbooking/model/booking.dart';
import 'package:meta/meta.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());
  Dio dio = Dio();

  Future<void> addBooking(
      String userId,
      String movieId,
      int totalPrice,
      List<String> selectSeats,
      String cinemaId,
      DateTime date,
      String time) async {
    try {
      final response =
          await dio.post("http://10.0.2.2:9999/booking/api/addBooking", data: {
        'user': userId,
        'movie': movieId,
        'totalPrice': totalPrice,
        'selectSeat': selectSeats,
        'cinema': cinemaId,
        'date': date.toIso8601String(),
        'time': time
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final Booking booking = Booking.fromJson(responseData);
        emit(BookingSuccess(booking));
      } else {
        emit(BookingError("Có lỗi rồi : ${response.statusMessage}"));
      }
    } catch (e) {
      print('Lỗi bỏ mẹ : $e');
    }
  }

  Future<void> paymentBooking(String bookingId, String paymentMethod) async {
    try {
      final response = await dio.post(
          "http://10.0.2.2:9999/booking/api/paybooking",
          data: {'bookingId': bookingId, 'paymentMethod': paymentMethod});

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final Booking booking = Booking.fromJson(responseData);
        emit(BookingSuccess(booking));
      } else {
        emit(BookingError("Lỗi lòi"));
      }
    } catch (e) {
      print('Lỗi rồi : $e');
    }
  }

  Future<void> deleteBooking(String bookingId) async {
    try {
      final response = await dio.delete(
          "http://10.0.2.2:9999/booking/api/deleteBooking",
          data: {'bookingId': bookingId});
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final Booking booking = Booking.fromJson(responseData);
        emit(BookingSuccess(booking));
      } else {
        emit(BookingError("Lỗi lòi"));
      }
    } catch (e) {
      print('Xóa lỗi : $e');
    }
  }
}
