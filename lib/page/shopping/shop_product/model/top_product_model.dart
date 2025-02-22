import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/base/base_model.dart';
import 'package:loto/base/destination.dart';
import 'package:loto/common/common.dart';
import 'package:loto/common/mesage_util.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/shopping/home/home_controller.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product_model.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';
import 'package:loto/page/shopping/moon_cake/widgets/select_box_layout.dart';
import 'package:loto/page/shopping/shop_product/model_data/top_categories_res.dart';
import 'package:loto/src/color_resource.dart';

import '../../cart/cart_controller.dart';

class TopProductModel extends BaseModel {
  TopProductModel() {
    onStart();
  }

  final RxBool isLoadingData = true.obs;

  final RxList<CakeProductModel> listCake = <CakeProductModel>[].obs;
  List<CakeProductModel> listCakeTemp = <CakeProductModel>[];
  final RxList<LsCategory> listCategories = <LsCategory>[].obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var cartQuantityItems = 0;

  ProductOrder? productOrder;
  final RxList<CakeProduct> listCakeBoxTemp = <CakeProduct>[].obs;
  final RxBool isStatusBuyBox = false.obs;
  final RxBool isShowBuyBox = false.obs;

  @override
  void onStart() {
    initData();
  }

  Future<void> initData() async {
    streamGetListCategories();
    await streamGetListProduct(isFeature: true);
    Get.find<HomeController>()
        .tastyRecipeModel
        .setListCateFeature(listCakeTemp);
  }

  Future<void> streamGetListCategories() async {
    isLoadingData.value = true;
    try {
      CollectionReference cakeRef =
          firestore.collection(DataRowName.Cakes.name);
      var products = await cakeRef.doc(DataCollection.Categories.name).get();

      TopCategoriesRes data =
          TopCategoriesRes.fromJson(products.data() as Map<String, dynamic>);
      listCategories.addAll(data.lsCategory ?? []);
      listCategories[previousIndex].isSelected.value = true;
      Get.find<HomeController>()
          .categoryRecipeModel
          .setListCategory(listCategories);
      isLoadingData.value = false;
    } catch (e) {
      print(e);
    }
  }

  Future<void> streamGetListProduct({
    int categoryID = 1,
    bool isFeature = false,
  }) async {
    isLoadingData.value = true;
    try {
      CollectionReference cakeRef =
          firestore.collection(DataRowName.Cakes.name);
      var products = cakeRef
          .doc(DataCollection.Products.name)
          .collection(DataCollection.MoonCakes.name);

      List<CakeProductModel> listTemp = [];
      QuerySnapshot<Map<String, dynamic>> data;
      if(categoryID > 1){
        data = await products.where("product_category", isEqualTo: categoryID).get();
      }else{
        data = await products.where("is_feature", isEqualTo: isFeature).get();
      }
      // print(data.docChanges.length);
      for (var e in data.docs) {
        CakeProduct product = CakeProduct.fromJson(e.data());
        CakeProductModel cakeProductModel = CakeProductModel(product);
        listTemp.add(cakeProductModel);
      }
      listTemp.sort((a, b) {
        return (a.cakeProduct.sortOrder ?? 0)
            .compareTo(b.cakeProduct.sortOrder ?? 0);
      });

      listCakeTemp.clear();
      listCakeTemp.addAll(listTemp);
      listCake.value = listCakeTemp;
      listCake.refresh();
      isLoadingData.value = false;
    } catch (e) {
      isLoadingData.value = false;
    }
  }

  @override
  void onFinish() {}

  void onTapDetail(CakeProduct cakeProduct) {
    Get.nestedKey(1)?.currentState?.pushNamed(
          Destination.shop_product_detail.route,
          arguments: cakeProduct,
        );
  }

  void listClick(CakeProduct product) async {
    print(product.toJson());
    if (!isStatusBuyBox.value) {
      await AppCommon.singleton.onAddCartToServer(onHandleNext: (){
        if (checkExistedInBox(product) != null) {
          checkExistedInBox(product)!.quantity += product.quantity;
          AppCommon.singleton.currentProductInCart.refresh();
          return;
        }
        productOrder = ProductOrder();
        productOrder?.productMoonCakeList = [];
        productOrder?.boxCake = product;
        productOrder?.quantity.value = 1;
        productOrder?.productType = 2;

        AppCommon.singleton.currentProductInCart.add(productOrder!);
        Get.find<CartController>().countTotalPrice();
      });
      MessageUtil.show(
        msg: "Thêm vào giỏ hàng thành công",
        duration: 1,
      );
      return;
    }
    if (listCakeBoxTemp.length == productOrder?.boxCake?.productType) {
      MessageUtil.show(msg: "Số lượng bánh đã đủ");
      return;
    }
    listCakeBoxTemp.add(product);
  }

  ProductOrder? checkExistedInBox(CakeProduct product) {
    var data =
        AppCommon.singleton.currentProductInCart.firstWhereOrNull((element) {
      return product.productID == element.boxCake!.productID &&
          product.numberEggs == element.boxCake!.numberEggs &&
          product.productType == element.boxCake!.productType;
    });
    if (data != null) {
      return data;
    }
    return null;
  }

  int previousIndex = 0;
  void onSelectCategory(int index) {
    if (previousIndex != index) {
      listCategories[previousIndex].isSelected.value = false;
      previousIndex = index;
      listCategories[index].isSelected.value = true;
      print(listCategories[index].categoryId);
      final bool isFeature = listCategories[index].categoryId == 1;
      isShowBuyBox.value = listCategories[index].categoryId == 4;
      isStatusBuyBox.value = false;
      if(!isShowBuyBox.value){
        onTapDeleteBuyBox();
      }
      streamGetListProduct(categoryID: listCategories[index].categoryId ?? 0, isFeature: isFeature);
    }
  }

  Future<void> onShowOrCompleteBuyBox(BuildContext context) async {
    if (isStatusBuyBox.value) {
      if (listCakeBoxTemp.length < (productOrder?.boxCake!.productType ?? 0)) {
        MessageUtil.show(
          msg: "Số lượng bánh chưa đủ, hãy chọn thêm",
          duration: 1,
        );
        return;
      }
      await AppCommon.singleton.onAddCartToServer(onHandleNext: (){
        productOrder?.productMoonCakeList!.addAll(listCakeBoxTemp);
        AppCommon.singleton.currentProductInCart.add(productOrder!);

        listCakeBoxTemp.clear();
        isStatusBuyBox.value = false;
      });
      MessageUtil.show(
        msg: "Thêm vào giỏ hàng thành công",
        duration: 1,
      );
      return;
    }
    showBoxCakeDialog(context);
  }

  void showBoxCakeDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Select Box",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) {
        return SelectBoxLayout(
          controller: this,
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          );
        } else {
          tween = Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          );
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  void onSelectBuyBox(CakeProduct product) {
    productOrder = ProductOrder();
    productOrder?.productMoonCakeList = [];
    productOrder?.boxCake = product;
    productOrder?.quantity.value = 1;
    productOrder?.productType = 1;

    isStatusBuyBox.value = true;

    Get.back();
  }

  void onTapDeleteBuyBox() {
    productOrder = ProductOrder();

    isStatusBuyBox.value = false;
    listCakeBoxTemp.clear();
  }

  Stream<QuerySnapshot<Object?>> streamGetListBox() {
    CollectionReference cakeRef = firestore.collection(DataRowName.Cakes.name);
    var products = cakeRef
        .doc(DataCollection.Products.name)
        .collection(DataCollection.Boxs.name);

    return products.snapshots();
  }

  String formatCurrency(double d) {
    return "${FormatUtils.oCcy.format(d)}đ";
  }

  Color getBackgroundColor(String? color, BuildContext context) {
    if (color == null) return ColorResource.color_background_light;
    return Color(int.parse("0xFF$color"));
  }

  void onRemoveItemInBox(int index) {
    listCakeBoxTemp.removeAt(index);
  }
}
