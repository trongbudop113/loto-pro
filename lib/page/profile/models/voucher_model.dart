class VoucherModel {
  final String name;
  final String code;
  final String expireDate;
  final double discount;
  final bool isUsed;

  VoucherModel({
    required this.name,
    required this.code,
    required this.expireDate,
    required this.discount,
    this.isUsed = false,
  });
}