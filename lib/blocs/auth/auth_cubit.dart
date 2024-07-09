import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meta/meta.dart';

import '../../model/auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Dio dio = Dio();

  Future<void> register(String username, String avata, int phone, String email,
      String password) async {
    try {
      final response =
          await dio.post("http://10.0.2.2:9999/auth/api/register", data: {
        'username': username,
        'avata': avata,
        'phone': phone,
        'email': email,
        'password': password
      });

      if (response.statusCode == 200) {
        final Auth auth = Auth.fromJson(response.data);
        emit(AuthLoaded(auth));
      } else {
        emit(AuthError("Đã có lỗi ${response.statusMessage}"));
      }
    } catch (e) {
      print('Có lỗi $e}');
    }
  }

  Future<void> verify(String email, String otp) async {
    try {
      final response = await dio.post("http://10.0.2.2:9999/auth/api/verify",
          data: {'email': email, 'otp': otp});
      if (response.statusCode == 200) {
        final Auth auth = Auth.fromJson(response.data);
        emit(AuthLoaded(auth));
      } else {
        emit(AuthError("Lỗi"));
      }
    } catch (e) {
      print('Xác nhận OTP lỗi $e');
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await dio.post("http://10.0.2.2:9999/auth/api/login",
          data: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        final decodeToken = JwtDecoder.decode(response.data['token']);
        final Auth auth = Auth(
          id: decodeToken['id'],
          email: decodeToken['email'],
          phone: decodeToken['phone'],
          username: decodeToken['username'],
          avata: decodeToken['avata'],
          password: decodeToken['password'],
          otp: decodeToken['otp'],
          otpVerifyed: decodeToken['otpVerifyed']
        );

        emit(AuthLoaded(auth));
      }else{
        emit(AuthError("Lỗi đăng nhập"));
      }
    } catch (e) {
      print('Đăng nhập thất bại $e');
    }
  }
}
