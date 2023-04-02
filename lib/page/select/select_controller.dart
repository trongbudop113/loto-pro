import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/home/models/item_model.dart';
import 'package:loto/page/select/models/select_paper.dart';

class SelectBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SelectController());
  }
}

class SelectController extends GetxController {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  SelectPaper covertData(Map<String, dynamic> data){
    return SelectPaper.fromJson(data);
  }

  int convertColor(String color){
    return int.parse(color);
  }

  Future<void> addPaperData() async {
    try{
      List<ItemRowModel> listData = ItemRowModel.exData();
      SelectPaper selectPaper = SelectPaper();
      selectPaper.papers = listData;
      selectPaper.color = "0xFFFC29BD";
      selectPaper.selectedName = "";
      selectPaper.paperName = " Tờ Hồng 2";
      selectPaper.isSelected = false;
      selectPaper.createDate = DateTime.now().millisecondsSinceEpoch;
      selectPaper.sortOrder = 4;

      CollectionReference userCollection = firestore.collection(DataRowName.Papers.name);

      await userCollection.doc("pink_two").set(selectPaper.toJson());

    }catch(e){
      e.printInfo(info: "addPaperData");
    }

  }

  Stream<QuerySnapshot<Object?>> streamGetPapers() {
    CollectionReference roomRef = firestore.collection(DataRowName.Papers.name);

    return roomRef.snapshots();
  }

  void goToManager(){
    addPaperData();
  }

  void onSelectPaper(){

  }

}