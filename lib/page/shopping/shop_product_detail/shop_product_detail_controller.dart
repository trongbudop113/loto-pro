import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/shopping/about_us/model/inbox/inbox_model.dart';
import 'package:loto/page/shopping/about_us/model/inbox/inbox_view.dart';
import 'package:loto/page/shopping/about_us/model/inbox/inbox_view_mobile.dart';
import 'package:loto/page/shopping/home_main/model/footer/footer_model.dart';
import 'package:loto/page/shopping/home_main/model/footer/footer_view.dart';
import 'package:loto/page/shopping/home_main/model/footer/footer_view_mobile.dart';
import 'package:loto/page/shopping/shop_product_detail/model/top_description/top_description_model.dart';
import 'package:loto/page/shopping/shop_product_detail/model/top_description/top_description_view.dart';
import 'package:loto/page/shopping/shop_product_detail/model/top_description/top_description_view_mobile.dart';

import '../moon_cake/models/cake_product.dart';

class BlogDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BlogDetailController());
  }
}

class BlogDetailController extends GetxController {
  List<Widget> listModelView = [];
  List<Widget> listModelViewMobile = [];
  final box = GetStorage();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  initData() async {
    var data = Get.routing.args;

    CakeProduct cakeProduct;
    if (data == null) {
      String productID = box.read("product_id");
      CollectionReference cakeRef =
          firestore.collection(DataRowName.Cakes.name);
      DocumentSnapshot productsDetail = await cakeRef
          .doc(DataCollection.Products.name)
          .collection(DataCollection.MoonCakes.name)
          .doc(productID)
          .get();
      cakeProduct =
          CakeProduct.fromJson(productsDetail.data() as Map<String, dynamic>);
    } else {
      cakeProduct = Get.arguments as CakeProduct;
      box.write("product_id", cakeProduct.productID);
    }

    TopDescriptionModel topDescriptionModel =
        TopDescriptionModel(data: cakeProduct);
    InboxModel inboxModel = InboxModel();
    FooterModel footerModel = FooterModel();

    listModelView.addAll(
      [
        SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Get.nestedKey(1)?.currentState?.pop();
                },
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.transparent,
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              )
            ],
          ),
        ),
        TopDescriptionView(
          model: topDescriptionModel,
        ),
        InboxView(
          model: inboxModel,
        ),
        FooterView(
          model: footerModel,
        ),
      ],
    );


    listModelViewMobile.addAll(
      [
        TopDescriptionViewMobile(
          model: topDescriptionModel,
        ),
        InboxViewMobile(
          model: inboxModel,
        ),
        FooterViewMobile(
          model: footerModel,
        ),
      ],
    );
  }
}
