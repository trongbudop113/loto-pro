import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/common/mesage_util.dart';
import 'package:loto/common/utils.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/profile/order_manager/order_detail_manager/models/status_order.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product_model.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';
import 'package:loto/page/shopping/moon_cake/widgets/select_box_layout.dart';
import 'package:loto/page/shopping/moon_cake/widgets/select_filter_layout.dart';
import 'package:loto/page_config.dart';
import 'package:loto/src/color_resource.dart';
import 'package:tiengviet/tiengviet.dart';

class MoonCakeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MoonCakeController());
  }
}

class MoonCakeController extends GetxController {

  var scaffoldKey = GlobalKey<ScaffoldState>();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final List<StatusOrder> listFilter = StatusOrder.listFilterExample();
  final Rx<StatusOrder> filterData = StatusOrder().obs;

  var cartQuantityItems = 0;

  ProductOrder? productOrder;
  final RxList<CakeProduct> listCakeBoxTemp = <CakeProduct>[].obs;
  final RxBool isStatusBuyBox = false.obs;

  final RxBool isLoadingData = true.obs;

  final RxList<CakeProductModel> listCake = <CakeProductModel>[].obs;
  List<CakeProductModel> listCakeTemp = <CakeProductModel>[];

  var searchController = TextEditingController();

  void listClick(CakeProduct product) async {
    print(product.toJson());
    if (!isStatusBuyBox.value) {
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
      MessageUtil.show(
        msg: "Thêm vào giỏ hàng thành công",
        duration: 1,
      );
      return;
    }
    if (listCakeBoxTemp.length == productOrder?.boxCake!.productType) {
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

  @override
  void onInit() {
    streamGetListProduct();
    initData();
    super.onInit();
  }

  void initData(){
    listFilter.first.isSelected.value = true;
    filterData.value = listFilter.first;
  }

  Future<void> streamGetListProduct() async{
    isLoadingData.value = true;
    try{
      CollectionReference cakeRef = firestore.collection(DataRowName.Cakes.name);
      var products = cakeRef
          .doc(DataCollection.Products.name)
          .collection(DataCollection.MoonCakes.name)
          .orderBy("sort_order", descending: false);

      List<CakeProductModel> listTemp = [];
      var data = await products.get();
      for (var e in data.docs) {
        CakeProduct product = CakeProduct.fromJson(e.data());
        CakeProductModel cakeProductModel = CakeProductModel(product);
        listTemp.add(cakeProductModel);
      }

      listCakeTemp.clear();
      listCakeTemp.addAll(listTemp);
      listCake.value = listCakeTemp;
      isLoadingData.value = false;
    }catch(e){
      isLoadingData.value = false;
    }
  }

  Future<void> streamGetListProductByFilter(int filter) async {
    isLoadingData.value = true;
    try{
      CollectionReference cakeRef = firestore.collection(DataRowName.Cakes.name);
      var products = cakeRef
          .doc(DataCollection.Products.name)
          .collection(DataCollection.MoonCakes.name)
          .where("product_type", isEqualTo: filter);

      List<CakeProductModel> listTemp = [];
      var data = await products.get();
      for (var e in data.docs) {
        CakeProduct product = CakeProduct.fromJson(e.data());
        CakeProductModel cakeProductModel = CakeProductModel(product);
        listTemp.add(cakeProductModel);
      }

      listCake.clear();
      listCake.addAll(listTemp);
      isLoadingData.value = false;
    }catch(e){
      e.printInfo(info: "streamGetListProductByFilter");
      isLoadingData.value = false;
    }
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

  void onClickDetail(CakeProduct moonCakeProduct) {
    Get.toNamed(PageConfig.MOON_CAKE_DETAIL, arguments: moonCakeProduct);
  }

  void goToCart() {
    Get.toNamed(PageConfig.CART);
  }

  Color getBackgroundColor(String? color, BuildContext context) {
    if (color == null) return ColorResource.color_background_light;
    return Color(int.parse("0xFF$color"));
  }

  ProductOrder? currentProductInCart(ProductOrder product) {
    var data = AppCommon.singleton.currentProductInCart.firstWhereOrNull(
        (e) => e.boxCake?.productID == product.boxCake?.productID);
    if (data != null) {
      return data;
    }
    return null;
  }

  void onShowOrCompleteBuyBox(BuildContext context) {
    if (isStatusBuyBox.value) {
      if (listCakeBoxTemp.length < (productOrder?.boxCake!.productType ?? 0)) {
        MessageUtil.show(
          msg: "Số lượng bánh chưa đủ, hãy chọn thêm",
          duration: 1,
        );
        return;
      }
      productOrder?.productMoonCakeList!.addAll(listCakeBoxTemp);
      AppCommon.singleton.currentProductInCart.add(productOrder!);

      listCakeBoxTemp.clear();
      isStatusBuyBox.value = false;
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

  void showFilterDialog(BuildContext context){
    showGeneralDialog(
      context: context,
      barrierLabel: "Change Status",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) {
        return SelectFilterLayout(controller: this,);
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(
            begin: Offset(-1, 0),
            end: Offset.zero,
          );
        } else {
          tween = Tween(
            begin: Offset(1, 0),
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

  void onRemoveItemInBox(int index) {
    listCakeBoxTemp.removeAt(index);
  }

  Future<void> onSelectFilter(StatusOrder data) async {
    for (var e in listFilter) {
      if(e.statusID == data.statusID){
        e.isSelected.value = true;
      }else{
        e.isSelected.value = false;
      }
    }

    data.statusID.printInfo(info: "aaaaa");
    if(data.statusID == 1){
      await streamGetListProduct();
    }else{
      await streamGetListProductByFilter(data.statusID!);
    }

    filterData.value = data;
    Get.back();
  }

  Timer? _debounce;

  void onChangeSearchCake(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      onQueryCake(value.trim().toString());
    });
  }

  void onQueryCake(String value){
    if(value == "") {
      listCake.value = listCakeTemp;
      return;
    }
    String convertText = TiengViet.parse(value).toLowerCase();
    var data = listCakeTemp.where((e){
      String productName = TiengViet.parse(e.productName).toLowerCase();
      return productName.contains(convertText);
    }).toList();
    listCake.value = data;
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }

  void onTapMenu(BuildContext context) {
    scaffoldKey.currentState?.openDrawer();
  }

  void onCloseDraw() {
    scaffoldKey.currentState?.closeDrawer();
  }
}
