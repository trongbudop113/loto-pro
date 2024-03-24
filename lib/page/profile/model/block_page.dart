import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loto/database/data_name.dart';

class BlockPage {
  List<String>? idCollection;
  String? idBlock;
  String? nameBlock;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<BlockChildPage> get listChildMenu {
    List<BlockChildPage> list = [];

    if((idCollection ?? []).isNotEmpty){
      for (var e in idCollection!) {
        BlockChildPage blockChildPage = BlockChildPage();
        blockChildPage.collectionID = e;
        blockChildPage.childMenuStream = getChildMenu(collection: e, idBlock: idBlock ?? '');
        list.add(blockChildPage);
      }
    }

    return list;
  }

  Stream<QuerySnapshot<Object?>> getChildMenu({required String collection, required String idBlock}) {
    CollectionReference collectionRef = firestore.collection(DataRowName.Menus.name);
    return collectionRef.doc(idBlock).collection(collection).snapshots();
  }

  BlockPage({this.idCollection, this.idBlock, this.nameBlock});

  BlockPage.fromJson(Map<String, dynamic> json) {
    idCollection = json['id_collection'].cast<String>();
    idBlock = json['id_block'];
    nameBlock = json['name_block'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_collection'] = this.idCollection;
    data['id_block'] = this.idBlock;
    data['name_block'] = this.nameBlock;
    return data;
  }
}

class BlockChildPage{
  Stream<QuerySnapshot<Object?>>? childMenuStream;
  String? collectionID;

  BlockChildPage({this.childMenuStream, this.collectionID});
}