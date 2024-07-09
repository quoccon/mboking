part of 'movie_cubit.dart';

@immutable
sealed class MovieState extends Equatable {}

final class MovieInitial extends MovieState {
  @override
  List<Object?> get props => [];
}

final class MovieLoaded extends MovieState {
  final List<MovieElement> movies;

  MovieLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class MovieError extends MovieState {
  final String error;

  MovieError(this.error);

  @override
  List<Object?> get props => [error];
}
