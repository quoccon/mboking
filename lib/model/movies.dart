class Movie {
  Movie({
    required this.movie,
  });

  final List<MovieElement> movie;

  factory Movie.fromJson(Map<String, dynamic> json){
    return Movie(
      movie: json["movie"] == null ? [] : List<MovieElement>.from(json["movie"]!.map((x) => MovieElement.fromJson(x))),
    );
  }

}

class MovieElement {
  MovieElement({
    required this.id,
    required this.movieName,
    required this.imageMovie,
    required this.trailer,
    required this.language,
    required this.duration,
    required this.director,
    required this.plot,
    required this.actor,
    required this.ageLimit,
    required this.releaseDate,
    required this.endDate,
    required this.cinemas,
    required this.showDate,
    required this.isHide,
    required this.v,
  });

  final String? id;
  final String? movieName;
  final String? imageMovie;
  final String? trailer;
  final String? language;
  final int? duration;
  final String? director;
  final String? plot;
  final List<String> actor;
  final int? ageLimit;
  final DateTime? releaseDate;
  final DateTime? endDate;
  final List<Cinema> cinemas;
  final List<ShowDate> showDate;
  final bool? isHide;
  final int? v;

  factory MovieElement.fromJson(Map<String, dynamic> json){
    return MovieElement(
      id: json["_id"],
      movieName: json["movieName"],
      imageMovie: json["imageMovie"],
      trailer: json["trailer"],
      language: json["language"],
      duration: json["duration"],
      director: json["director"],
      plot: json["plot"],
      actor: json["actor"] == null ? [] : List<String>.from(json["actor"]!.map((x) => x)),
      ageLimit: json["age_limit"],
      releaseDate: DateTime.tryParse(json["release_date"] ?? ""),
      endDate: DateTime.tryParse(json["end_date"] ?? ""),
      cinemas: json["cinemas"] == null ? [] : List<Cinema>.from(json["cinemas"]!.map((x) => Cinema.fromJson(x))),
      showDate: json["showDate"] == null ? [] : List<ShowDate>.from(json["showDate"]!.map((x) => ShowDate.fromJson(x))),
      isHide: json["isHide"],
      v: json["__v"],
    );
  }

}

class Cinema {
  Cinema({
    required this.id,
    required this.nameCinema,
    required this.location,
    required this.imageCinema,
    required this.seat,
    required this.v,
  });

  final String? id;
  final String? nameCinema;
  final String? location;
  final String? imageCinema;
  final List<Seat> seat;
  final int? v;

  factory Cinema.fromJson(Map<String, dynamic> json){
    return Cinema(
      id: json["_id"],
      nameCinema: json["nameCinema"],
      location: json["location"],
      imageCinema: json["imageCinema"],
      seat: json["seat"] == null ? [] : List<Seat>.from(json["seat"]!.map((x) => Seat.fromJson(x))),
      v: json["__v"],
    );
  }

}

class Seat {
  Seat({
    required this.isSelected,
    required this.id,
    required this.row,
    required this.number,
    required this.price,
    required this.v,
  });

  final bool? isSelected;
  final String? id;
  final String? row;
  final int? number;
  final int? price;
  final int? v;

  factory Seat.fromJson(Map<String, dynamic> json){
    return Seat(
      isSelected: json["isSelected"],
      id: json["_id"],
      row: json["row"],
      number: json["number"],
      price: json["price"],
      v: json["__v"],
    );
  }

}

class ShowDate {
  ShowDate({
    required this.id,
    required this.showDate,
    required this.time,
    required this.v,
  });

  final String? id;
  final DateTime? showDate;
  final List<String> time;
  final int? v;

  factory ShowDate.fromJson(Map<String, dynamic> json){
    return ShowDate(
      id: json["_id"],
      showDate: DateTime.tryParse(json["showDate"] ?? ""),
      time: json["time"] == null ? [] : List<String>.from(json["time"]!.map((x) => x)),
      v: json["__v"],
    );
  }

}
