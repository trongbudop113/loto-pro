class MoonCakeProduct {
  String? productID;
  String? productName;
  int? productType;
  String? productImage;
  String? productColor;
  int? productPrice;
  bool? isShow;

  int numberEggs = 1;
  int quantity = 1;

  MoonCakeProduct(
      {this.productID,
        this.productColor,
        this.productImage,
        this.productName,
        this.productPrice,
        this.productType,
        this.isShow
      });

  MoonCakeProduct.fromJson(Map<String, dynamic> json) {
    productPrice = json['product_price'];
    productType = json['product_type'];
    productName = json['product_name'];
    productColor = json['product_color'];
    productImage = json['product_image'];
    productID = json['product_id'];
    isShow = json['is_show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productPrice;
    data['product_type'] = productType;
    data['product_name'] = productName;
    data['product_image'] = productImage;
    data['product_id'] = productID;
    data['product_color'] = productColor;
    data['is_show'] = isShow;
    data['number_eggs'] = numberEggs;
    data['quantity_order'] = quantity;
    return data;
  }
}