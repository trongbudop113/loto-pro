import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loto/database/data_name.dart';

abstract class BlockBodyProvider{

  Stream<QuerySnapshot<Object?>> streamGetBlockBody() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference menuRef = firestore.collection(DataRowName.Menus.name);
    var blockLeft = menuRef.doc("Utilities").collection('Utilities').where("is_show", isEqualTo: true);;

    return blockLeft.snapshots();
  }
}