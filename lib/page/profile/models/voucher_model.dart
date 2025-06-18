class VoucherModel {
  final String id;
  final String name;
  final String code;
  final String expireDate;
  final double discount;
  final String? description;
  final double? minOrderAmount;
  final DateTime? createdAt;
  final DateTime? expiredAt;

  VoucherModel({
    required this.id,
    required this.name,
    required this.code,
    required this.expireDate,
    required this.discount,
    this.description,
    this.minOrderAmount,
    this.createdAt,
    this.expiredAt,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      expireDate: json['expireDate'] ?? '',
      discount: (json['discount'] ?? 0).toDouble(),
      description: json['description'],
      minOrderAmount: json['minOrderAmount']?.toDouble(),
      createdAt: json['createdAt'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(json['createdAt'])
          : null,
      expiredAt: json['expiredAt'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(json['expiredAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'expireDate': expireDate,
      'discount': discount,
      'description': description,
      'minOrderAmount': minOrderAmount,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'expiredAt': expiredAt?.millisecondsSinceEpoch,
    };
  }

  bool get isExpired {
    if (expiredAt != null) {
      return DateTime.now().isAfter(expiredAt!);
    }
    return false;
  }

  bool get isValid {
    return !isExpired;
  }

  String get discountText {
    if (discount >= 1) {
      return '${discount.toInt()}đ';
    } else {
      return '${(discount * 100).toInt()}%';
    }
  }
}