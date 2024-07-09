class Vorcher {
  Vorcher({
    required this.id,
    required this.code,
    required this.discount,
    required this.content,
    required this.expiryDate,
    required this.isActive,
    required this.maxUsage,
    required this.currentUsage,
    required this.createAt,
    required this.v,
  });

  final String? id;
  final String? code;
  final int? discount;
  final String? content;
  final DateTime? expiryDate;
  final bool? isActive;
  final int? maxUsage;
  final int? currentUsage;
  final DateTime? createAt;
  final int? v;

  factory Vorcher.fromJson(Map<String, dynamic> json){
    return Vorcher(
      id: json["_id"],
      code: json["code"],
      discount: json["discount"],
      content: json["content"],
      expiryDate: DateTime.tryParse(json["expiryDate"] ?? ""),
      isActive: json["isActive"],
      maxUsage: json["maxUsage"],
      currentUsage: json["currentUsage"],
      createAt: DateTime.tryParse(json["createAt"] ?? ""),
      v: json["__v"],
    );
  }

}
