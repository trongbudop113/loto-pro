import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loto/database/data_name.dart';

abstract class BlockLeftProvider{

  Stream<QuerySnapshot<Object?>> streamGetBlockLeft() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference menuRef = firestore.collection(DataRowName.Menus.name);
    var blockLeft = menuRef.doc("Blocks").collection('BlockLeft');

    return blockLeft.snapshots();
  }
}