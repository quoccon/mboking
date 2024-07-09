import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mbooking/model/movies.dart';
import 'package:meta/meta.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieInitial());
  Dio dio = Dio();

  Future<void> getFilm() async {
    try {
      final response = await dio.get("http://10.0.2.2:9999/movie/api/getfilm");
      if (response.statusCode == 200) {
        List<dynamic> data = List<dynamic>.from(response.data["movie"]);
        List<MovieElement> movies = data.map((json) => MovieElement.fromJson(json)).toList();
        emit(MovieLoaded(movies));
      } else {
        emit(MovieError("Lỗi tải phim ${response.statusMessage}"));
      }
    } catch (e) {
      print('Đã có lỗi khi lấy danh sách phim : $e');
      emit(MovieError("Đã có lỗi khi lấy danh sách phim"));
    }
  }
}
