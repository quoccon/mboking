import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../model/vorcher.dart';

part 'vorcher_state.dart';

class VorcherCubit extends Cubit<VorcherState> {
  VorcherCubit() : super(VorcherInitial());
  
  Dio dio = Dio();
  
  Future<void> getVoucher() async{
    try{
      final response = await dio.get("http://localhost:9999/booking/api/getVorcher");
      if(response.statusCode == 200) {
        List<Vorcher> data = (response.data as List).map((json) => Vorcher.fromJson(json)).toList();
        emit(VorcherLoaded(data));
      }else{
        emit(VorcherError("Lỗi lấy danh sách"));
      }
    }catch(e){
      print('Lỗi : $e');
    }
  }
}
