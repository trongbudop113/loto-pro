import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/home/models/item_model.dart';
import 'package:loto/page/select/models/select_paper.dart';


class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends GetxController {

  final RxList<SelectPaper> listData = <SelectPaper>[].obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late String roomID;

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  Stream<DocumentSnapshot<Object?>> streamGetDataRoom() {
    CollectionReference roomRef = firestore.collection(DataRowName.Rooms.name);

    return roomRef.doc(roomID).collection(roomID).doc(roomID).snapshots();
  }

  void getArgument(){
    var arguments = Get.arguments;

    listData.addAll(arguments[0] as List<SelectPaper>);
    roomID = arguments[1] as String ?? '';
  }

  Future<void> setWinUser() async {
    try{
      CollectionReference roomCollection = firestore.collection(DataRowName.Rooms.name);
      await roomCollection.doc(roomID).collection(roomID).doc(roomID).set(
          {"isWin" : true}
      );
    }catch(e){
      e.printInfo(info: "setDefaultData");
    }
  }

  Future<void> onTapNumber(int i, int j, int k) async {
    int number = listData[i].papers![j].items![k].number ?? 0;
    if(number == 0){
      return;
    }
    listData[i].papers![j].items![k].isCheck.value = !listData[i].papers![j].items![k].isCheck.value;

    int count = 0;
    for(ItemModel data in listData[i].papers![j].items ?? []){
      if((data.number ?? 0) > 0 && data.isCheck.value){
        count++;
      }
    }

    if(count == 4){
      print('wait wait wait wait');
      return;
    }

    if(count == 5){
      await setWinUser();
      return;
    }
  }

  void onRefreshData(){
    for(var parent in listData){
      for(ItemRowModel element in parent.papers ?? []){
        if(!(element.typeFull ?? false)){
          for(ItemModel child in element.items ?? []){
            child.isCheck.value = false;
          }
        }
      }
    }
  }

  RxBool get isHasData {
    return (listData.isNotEmpty).obs;
  }

  int convertColor(String color){
    return int.parse(color);
  }

  @override
  void onClose() {
    onRefreshData();
    super.onClose();
  }

}