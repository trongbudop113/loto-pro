import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/shopping/moon_cake/models/order_moon_cake.dart';
import 'package:loto/page_config.dart';

class AppCommon {
  static final AppCommon singleton = AppCommon._internal();

  factory AppCommon() {
    return singleton;
  }

  AppCommon._internal();

  final RxList<ProductOrder> currentProductInCart = <ProductOrder>[].obs;

  RxInt get countCart {
    if (currentProductInCart.isEmpty) return 0.obs;
    int i = 0;
    for (var e in currentProductInCart) {
       i += e.quantity.value;
    }
    return i.obs;
  }

  User? get currentUser => FirebaseAuth.instance.currentUser;

  UserLogin userLogin(Object? data) {
    return UserLogin.fromJson(data as Map<String, dynamic>);
  }

  Future<UserLogin> getCurrentUserLogin() async {
    CollectionReference usersReference =
        FirebaseFirestore.instance.collection(DataRowName.Users.name);
    final getUSer = await usersReference.doc(currentUser?.uid ?? '').get();
    UserLogin userLogin =
        UserLogin.fromJson(getUSer.data() as Map<String, dynamic>);
    return userLogin;
  }

  Future<void> syncProductCart() async {
    if (!isLogin) {
      currentProductInCart.value = [];
      return;
    }
    CollectionReference usersReference =
        FirebaseFirestore.instance.collection(DataRowName.Cakes.name);
    final getData = await usersReference
        .doc(DataCollection.Cart.name)
        .collection(currentUser?.uid ?? '')
        .doc(currentUser?.uid ?? '')
        .get();
    if (!getData.exists) {
      currentProductInCart.value = [];
      return;
    }
    if (getData.data() == null) {
      currentProductInCart.value = [];
      return;
    }
    print("length" + currentProductInCart.length.toString());
    var data = getData.data() as Map<String, dynamic>;
    currentProductInCart.value = SaveCartServer.fromJson(data).lsCart ?? [];
  }

  Future<void> onAddCartToServer({Function? onHandleNext}) async {
    if (!isLogin) {
      await Get.toNamed(PageConfig.LOGIN);
      if(!isLogin) return;
    }
    CollectionReference usersReference =
        FirebaseFirestore.instance.collection(DataRowName.Cakes.name);
    final getData = await usersReference
        .doc(DataCollection.Cart.name)
        .collection(currentUser?.uid ?? '')
        .doc(currentUser?.uid ?? '')
        .get();
    if (!getData.exists) {
      currentProductInCart.value = [];
      if (onHandleNext != null) {
        onHandleNext.call();
        await usersReference
            .doc(DataCollection.Cart.name)
            .collection(currentUser?.uid ?? '')
            .doc(currentUser?.uid ?? '')
            .set(
          SaveCartServer(lsCart: currentProductInCart).toJson(),
        );
      }
    }else{
      if (getData.data() == null) {
        currentProductInCart.value = [];
        return;
      }
      var data = getData.data() as Map<String, dynamic>;
      currentProductInCart.value = SaveCartServer.fromJson(data).lsCart ?? [];

      if (onHandleNext != null) {
        onHandleNext.call();
        await usersReference
            .doc(DataCollection.Cart.name)
            .collection(currentUser?.uid ?? '')
            .doc(currentUser?.uid ?? '')
            .update(
          SaveCartServer(lsCart: currentProductInCart).toJson(),
        );
      }
    }
  }

  Future<void> onUpdateCartToServer() async {
    CollectionReference usersReference =
    FirebaseFirestore.instance.collection(DataRowName.Cakes.name);
    await usersReference
        .doc(DataCollection.Cart.name)
        .collection(currentUser?.uid ?? '')
        .doc(currentUser?.uid ?? '')
        .update(
      SaveCartServer(lsCart: currentProductInCart).toJson(),
    );
  }

  bool get isLogin =>
      currentUser != null && (currentUser?.uid ?? '').isNotEmpty;

  String blogRoute = "";
  String shopRoute = "";
}
