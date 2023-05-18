import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loto/database/data_name.dart';

abstract class BannerMenuProvider{

  Stream<QuerySnapshot<Object?>> streamGetBanner() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference menuRef = firestore.collection(DataRowName.Menus.name);
    var bannerMenu = menuRef.doc("Banners").collection('AllBanner');

    return bannerMenu.snapshots();
  }
}