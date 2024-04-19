
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';
import 'package:loto/page_config.dart';

class ProductManagerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProductManagerController());
  }
}

class ProductManagerController extends GetxController {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamGetProduct(){
    CollectionReference cakeRef = firestore.collection(DataRowName.Cakes.name);
    var products = cakeRef
        .doc(DataCollection.Products.name)
        .collection(DataCollection.MoonCakes.name)
        .orderBy("sort_order", descending: false);

    return products.snapshots();
  }

  void onTapItem(CakeProduct cake) {
    Get.toNamed(PageConfig.EDIT_PRODUCT_MANAGER, arguments: cake);
  }
}