class Booking {
  Booking({
    required this.user,
    required this.movie,
    required this.totalPrice,
    required this.paymentMethod,
    required this.paid,
    required this.expiresAt,
    required this.id,
    required this.v,
  });

  final String? user;
  final String? movie;
  final int? totalPrice;
  final dynamic paymentMethod;
  final bool? paid;
  final DateTime? expiresAt;
  final String? id;
  final int? v;

  factory Booking.fromJson(Map<String, dynamic> json){
    return Booking(
      user: json["user"],
      movie: json["movie"],
      totalPrice: json["totalPrice"],
      paymentMethod: json["paymentMethod"],
      paid: json["paid"],
      expiresAt: DateTime.tryParse(json["expiresAt"] ?? ""),
      id: json["_id"],
      v: json["__v"],
    );
  }

}
