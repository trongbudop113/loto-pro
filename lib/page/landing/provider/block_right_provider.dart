import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';

abstract class BlockRightProvider{

  Stream<QuerySnapshot<Object?>> streamGetBlockRight() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference menuRef = firestore.collection(DataRowName.Menus.name);
    var BlockRight = menuRef.doc("Blocks").collection('BlockRight');

    return BlockRight.snapshots();
  }
}