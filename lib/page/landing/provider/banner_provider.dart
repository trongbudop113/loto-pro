import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';

abstract class BannerMenuProvider{

  final RxInt currentIndex = 0.obs;
  CarouselController bannerController = CarouselController();

  void onPageChange(int index){
    currentIndex.value = index;
  }

  void tapToIndex(int index){
    if(index == currentIndex.value) return;
    bannerController.animateToPage(index, duration: const Duration(milliseconds: 500));
  }

  Stream<QuerySnapshot<Object?>> streamGetBanner() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference menuRef = firestore.collection(DataRowName.Menus.name);
    var bannerMenu = menuRef.doc("Banners").collection('AllBanner');

    return bannerMenu.snapshots();
  }
}