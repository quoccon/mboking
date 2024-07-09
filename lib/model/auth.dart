class Auth {
  Auth({
    required this.username,
    required this.avata,
    required this.phone,
    required this.email,
    required this.password,
    required this.otp,
    required this.otpVerifyed,
    required this.id,
  });

  final String? username;
  final String? avata;
  final int? phone;
  final String? email;
  final String? password;
  final String? otp;
  final bool? otpVerifyed;
  final String? id;

  factory Auth.fromJson(Map<String, dynamic> json){
    return Auth(
      username: json["username"],
      avata: json["avata"],
      phone: json["phone"],
      email: json["email"],
      password: json["password"],
      otp: json["otp"],
      otpVerifyed: json["otpVerifyed"],
      id: json["_id"],
    );
  }

}
