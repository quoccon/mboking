class Bill {
  Bill({
    required this.id,
    required this.user,
    required this.movie,
    required this.totalPrice,
    required this.paymentMethod,
    required this.selectSeat,
    required this.cinema,
    required this.date,
    required this.time,
    required this.paid,
    required this.expiresAt,
    required this.v,
  });

  final String? id;
  final User? user;
  final Movie? movie;
  final int? totalPrice;
  final String? paymentMethod;
  final List<SelectSeat> selectSeat;
  final Cinema? cinema;
  final DateTime? date;
  final String? time;
  final bool? paid;
  final DateTime? expiresAt;
  final int? v;

  factory Bill.fromJson(Map<String, dynamic> json){
    return Bill(
      id: json["_id"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      movie: json["movie"] == null ? null : Movie.fromJson(json["movie"]),
      totalPrice: json["totalPrice"],
      paymentMethod: json["paymentMethod"],
      selectSeat: json["selectSeat"] == null ? [] : List<SelectSeat>.from(json["selectSeat"]!.map((x) => SelectSeat.fromJson(x))),
      cinema: json["cinema"] == null ? null : Cinema.fromJson(json["cinema"]),
      date: DateTime.tryParse(json["date"] ?? ""),
      time: json["time"],
      paid: json["paid"],
      expiresAt: DateTime.tryParse(json["expiresAt"] ?? ""),
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
  final List<String> seat;
  final int? v;

  factory Cinema.fromJson(Map<String, dynamic> json){
    return Cinema(
      id: json["_id"],
      nameCinema: json["nameCinema"],
      location: json["location"],
      imageCinema: json["imageCinema"],
      seat: json["seat"] == null ? [] : List<String>.from(json["seat"]!.map((x) => x)),
      v: json["__v"],
    );
  }

}

class Movie {
  Movie({
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
  final List<String> cinemas;
  final List<String> showDate;
  final bool? isHide;
  final int? v;

  factory Movie.fromJson(Map<String, dynamic> json){
    return Movie(
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
      cinemas: json["cinemas"] == null ? [] : List<String>.from(json["cinemas"]!.map((x) => x)),
      showDate: json["showDate"] == null ? [] : List<String>.from(json["showDate"]!.map((x) => x)),
      isHide: json["isHide"],
      v: json["__v"],
    );
  }

}

class SelectSeat {
  SelectSeat({
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

  factory SelectSeat.fromJson(Map<String, dynamic> json){
    return SelectSeat(
      isSelected: json["isSelected"],
      id: json["_id"],
      row: json["row"],
      number: json["number"],
      price: json["price"],
      v: json["__v"],
    );
  }

}

class User {
  User({
    required this.id,
    required this.username,
    required this.avata,
    required this.phone,
    required this.email,
    required this.password,
    required this.otpCreateAt,
    required this.otpVerifyed,
    required this.v,
  });

  final String? id;
  final String? username;
  final String? avata;
  final int? phone;
  final String? email;
  final String? password;
  final DateTime? otpCreateAt;
  final bool? otpVerifyed;
  final int? v;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["_id"],
      username: json["username"],
      avata: json["avata"],
      phone: json["phone"],
      email: json["email"],
      password: json["password"],
      otpCreateAt: DateTime.tryParse(json["otpCreateAt"] ?? ""),
      otpVerifyed: json["otpVerifyed"],
      v: json["__v"],
    );
  }

}
