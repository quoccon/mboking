import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mbooking/model/bill.dart';
import 'package:meta/meta.dart';

part 'bill_state.dart';

class BillCubit extends Cubit<BillState> {
  BillCubit() : super(BillInitial());

  Dio dio = Dio();

  Future<void> getBill(String bookingId) async {
    try {
      final response = await dio.get(
          "http://10.0.2.2:9999/booking/api/getbooking",
          data: {'bookingId': bookingId});

      if(response.statusCode == 200){
        final Bill bill = Bill.fromJson(response.data);
        emit(BillSuccess(bill));
      }else{
        emit(BillError("Lỗi vcl : ${response.statusMessage}"));
      }
    } catch (e) {
      print('Lỗi : $e');
    }
  }


}
