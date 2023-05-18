import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loto/database/data_name.dart';

abstract class GameMenuProvider{

  Stream<QuerySnapshot<Object?>> streamGetGame() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference menuRef = firestore.collection(DataRowName.Menus.name);
    var gameMenu = menuRef.doc("Games").collection('AllGame');

    return gameMenu.snapshots();
  }
}