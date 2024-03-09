import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/shopping/cart/cart_controller.dart';
import 'package:loto/page/shopping/cart/items/item_product_no_box.dart';
import 'package:loto/page/shopping/cart/items/item_product_with_box.dart';
import 'package:loto/src/style_resource.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Giỏ hàng"),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 55,
            child: Icon(Icons.arrow_back),
            color: Colors.transparent,
          ),
        ),
        actions: [
          _buttonActionDelete(context),
        ],
      ),
      body: Obx(() => Visibility(
            visible: controller.currentProductInCart.isNotEmpty,
            replacement: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: Lottie.asset(
                      'assets/cart_empty.json',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Chưa có sản phẩm trong giỏ hàng",
                    style: TextStyleResource.textStyleBlack(context).copyWith(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            child: width > 1000
                ? Row(
                    children: [
                      Container(
                        width: width * .5,
                        child: _buildListProduct(context, isScroll: true),
                        alignment: Alignment.topCenter,
                      ),
                      Container(
                        width: (width * .5) - 10,
                        alignment: Alignment.topCenter,
                        child: _buildPayment(context, isWeb: true),
                      )
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildListProduct(context, isScroll: true),
                        Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        _buildPayment(context, isWeb: false),
                      ],
                    ),
                  ),
          )),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: Colors.transparent,
      child: Obx(() => Visibility(
            visible: controller.currentProductInCart.isNotEmpty,
            child: GestureDetector(
              onTap: () {
                controller.onTapOrder();
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(60),
                ),
                alignment: Alignment.center,
                child: Text("Đặt hàng"),
              ),
            ),
          )),
    );
  }

  Widget _buildPayment(BuildContext context, {required bool isWeb}) {
    return Obx(() => Visibility(
          visible: controller.currentProductInCart.isNotEmpty,
          child: Container(
            margin: EdgeInsets.only(
              right: 15,
              top: 20,
              bottom: 20,
              left: 15
            ),
            child: Column(
              children: [
                Visibility(
                  visible: isWeb,
                  child: SizedBox(
                    height: 15,
                  ),
                ),
                Text(
                  "Thanh Toán:",
                  style: TextStyleResource.textStyleBlack(context)?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _buildRowPrice(context,
                    title: "Tạm tính", price: 0, isWeb: isWeb),
                SizedBox(
                  height: 15,
                ),
                _buildRowPrice(
                  context,
                  title: "Giảm giá",
                  price: 0,
                  isWeb: isWeb,
                ),
                SizedBox(
                  height: 15,
                ),
                Obx(() => _buildRowPrice(
                      context,
                      title: "Tổng tiền",
                      price: controller.finalPrice.value,
                      isWeb: isWeb,
                    )),
                SizedBox(
                  height: 25,
                ),
                _buildNote(context)
              ],
            ),
          ),
        ));
  }

  Widget _buildListProduct(BuildContext context, {required bool isScroll}) {
    return ListView.separated(
      padding: EdgeInsets.all(15),
      shrinkWrap: true,
      physics:
          isScroll ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
      itemBuilder: (c, i) {
        return Visibility(
          visible: controller.currentProductInCart[i].productType == 1,
          replacement: ItemProductNoBox(
            productItem: controller.currentProductInCart[i],
            controller: controller,
          ),
          child: ItemProductWithBox(
            productItem: controller.currentProductInCart[i],
            controller: controller,
          ),
        );
      },
      separatorBuilder: (c, i) {
        return Container(height: 15);
      },
      itemCount: controller.currentProductInCart.length,
    );
  }

  Widget _buttonActionDelete(BuildContext context) {
    return Obx(() => Visibility(
          visible: controller.currentProductInCart.isNotEmpty,
          child: GestureDetector(
            onTap: () {
              Dialogs.materialDialog(
                  msg: 'Bạn có chắc là xóa hết sản phẩm?',
                  title: "Thông báo",
                  color: Colors.white,
                  context: context,
                  dialogWidth: kIsWeb ? 0.3 : null,
                  onClose: (value) => print("returned value is '$value'"),
                  actions: [
                    IconsOutlineButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      text: 'Cancel',
                      iconData: Icons.cancel_outlined,
                      textStyle: TextStyle(color: Colors.grey),
                      iconColor: Colors.grey,
                    ),
                    IconsButton(
                      onPressed: () {
                        controller.onRemoveAllCart();
                        Navigator.of(context).pop();
                      },
                      text: "Delete",
                      iconData: Icons.delete,
                      color: Colors.red,
                      textStyle: TextStyle(color: Colors.white),
                      iconColor: Colors.white,
                    ),
                  ]);
            },
            child: Container(
              width: 55,
              alignment: Alignment.center,
              child: Icon(Icons.delete),
              color: Colors.transparent,
            ),
          ),
        ));
  }

  Widget _buildRowPrice(
    BuildContext context, {
    required String title,
    required double price,
    required bool isWeb,
  }) {
    return Row(
      mainAxisAlignment:
          isWeb ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Text(
          '$title:',
          style: TextStyleResource.textStyleBlack(context),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Text(
            controller.formatCurrency(price),
            textAlign: TextAlign.end,
            style: TextStyleResource.textStyleBlack(context),
          ),
        ),
      ],
    );
  }

  Widget _buildNote(BuildContext context){
    return TextFormField(
      minLines: 6,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        alignLabelWithHint: true,
        border: OutlineInputBorder(),
        labelText: 'Ghi chú',
      ),
    );
  }
}
