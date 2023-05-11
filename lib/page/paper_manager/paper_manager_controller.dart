import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/home/models/item_model.dart';
import 'package:loto/page/paper_manager/models/category_paper.dart';
import 'package:loto/page/paper_manager/widget/select_color_layout.dart';
import 'package:loto/page/paper_manager/widget/select_number_layout.dart';
import 'package:loto/page/select/models/select_paper.dart';

class PaperManagerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PaperManagerController());
  }
}

class PaperManagerController extends GetxController {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final Rx<SelectPaper> selectPaper = SelectPaper().obs;
  final RxList<ItemRowModelChange> listRow = <ItemRowModelChange>[].obs;
  final RxList<CategoryPaper> listCategory = <CategoryPaper>[].obs;
  bool isModeEdit = true;

  final RxInt colorPaper = 0.obs;
  final RxString namePaper = "Chưa chọn".obs;
  String categoryID = "";

  int convertColor(String color){
    return int.parse(color);
  }

  void onTapItem(int index, int indexChild, BuildContext context){
    if(isModeEdit){
      if((listRow[index].items![indexChild].number?.value ?? 0) == 0){
        return;
      }
    }
    showDialogSelectNumber(context, index, indexChild);
  }

  Future<void> showDialogSelectNumber(BuildContext context, int index, int indexChild) async {
    List<int> list = [];
    for(int i = (indexChild * 10); i < ((indexChild + 1) * 10); i++){
      if(i > 0){
        list.add(i);
      }
    }
    if(indexChild == 8){
      list.add(90);
    }
    var number = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
            ), //this right here
            child: SelectNumberWidget(listNumber: list),
          );
        });

    if(number != null){
      listRow[index].items![indexChild].number?.value = number;
    }
  }

  void onClickDone(){
    if(isModeEdit){
      onUpdatePaper();
    }else{
      onSetPaper();
    }
  }

  Future<void> onUpdatePaper() async {
    try{
      CollectionReference userCollection = firestore.collection(DataRowName.Papers.name);

      SelectPaperChange changeData = SelectPaperChange.convertData(selectPaper.value);
      changeData.papers = listRow;

      await userCollection.doc(selectPaper.value.paperID).update(changeData.toJson());
      Get.back(result: true);

    }catch(e){
      e.printInfo(info: "addPaperData");
    }

  }

  Future<void> onSetPaper() async {
    try{
      CollectionReference userCollection = firestore.collection(DataRowName.Papers.name);
      CollectionReference categoryCollection = firestore.collection(DataRowName.CategoryPaper.name);

      SelectPaperChange changeData = SelectPaperChange.convertData(selectPaper.value);
      changeData.papers = listRow;

      await userCollection.doc(selectPaper.value.paperID).set(changeData.toJson());
      await categoryCollection.doc(categoryID).set({
        "isAdd" : true
      });

      Get.back(result: true);

    }catch(e){
      e.printInfo(info: "addPaperData");
    }

  }

  void getParam(){
    if(Get.arguments != null){
      isModeEdit = true;
      SelectPaper data = Get.arguments as SelectPaper;
      selectPaper.value = data;
      colorPaper.value = convertColor(data.color!);
      namePaper.value = data.paperName ?? '';
    }else{
      isModeEdit = false;
      SelectPaper data = SelectPaper();
      data.papers = ItemRowModel.exData();
      selectPaper.value = data;
    }
    for(ItemRowModel item in selectPaper.value.papers ?? []){
      ItemRowModelChange itemRowModelChange = ItemRowModelChange();
      itemRowModelChange.typeFull = item.typeFull;
      if(!(item.typeFull ?? true)){
        List<ItemModelChange> lisTemp = [];
        for(ItemModel e in item.items ?? []){
          ItemModelChange itemModelChange = ItemModelChange();
          itemModelChange.number?.value = e.number ?? 0;
          lisTemp.add(itemModelChange);
        }
        itemRowModelChange.items = lisTemp;
      }else{
        itemRowModelChange.items = [];
      }
      listRow.add(itemRowModelChange);
    }

    getCategoryPaper();
  }

  RxBool get isHasData {
    if(!isModeEdit){
      return true.obs;
    }
    return ((selectPaper.value.paperID ?? '').isNotEmpty).obs;
  }

  Future<void> getCategoryPaper() async {
    if(isModeEdit){
      return;
    }
    CollectionReference categoryRef = firestore.collection(DataRowName.CategoryPaper.name);
    var data = await categoryRef.where('isAdd', isEqualTo: false).get();
    for(var item in data.docChanges){
      CategoryPaper categoryPaper = convertData(item.doc.data() as Map<String, dynamic>);
      listCategory.add(categoryPaper);
    }

    if(listCategory.isNotEmpty){
      var category = listCategory.first;
      selectPaper.value.paperName = category.paperName;
      selectPaper.value.paperID = category.paperID;
      selectPaper.value.color = category.color;
      colorPaper.value = convertColor(category.color!);
      namePaper.value = category.paperName ?? '';
      categoryID = category.categoryID ?? '';
    }
  }

  CategoryPaper convertData(Map<String, dynamic> data){
    return CategoryPaper.fromJson(data);
  }

  Future<void> showDialogSelectColorPaper(BuildContext context) async {
    if(isModeEdit){
      return;
    }
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
            ), //this right here
            child: SelectColorLayout(
              listCategoryPaper: listCategory,
              controller: this,
            ),
          );
        });
  }

  void onSelectPaper(CategoryPaper paper){
    selectPaper.value.paperName = paper.paperName;
    selectPaper.value.paperID = paper.paperID;
    selectPaper.value.color = paper.color;
    colorPaper.value = convertColor(paper.color!);
    namePaper.value = paper.paperName ?? '';
    categoryID = paper.categoryID ?? '';
  }

  @override
  void onInit() {
    getParam();
    super.onInit();
  }

}