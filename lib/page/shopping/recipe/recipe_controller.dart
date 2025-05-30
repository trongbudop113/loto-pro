import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/common/common.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/shopping/recipe/layout/edit_ingredient_layout.dart';
import 'package:loto/page/shopping/recipe/layout/edit_recipe_layout.dart';
import 'package:loto/page/shopping/recipe/model/ingredient.dart';
import 'package:loto/page/shopping/recipe/model/ingredient_form.dart';
import 'package:loto/page/shopping/recipe/model/recipe.dart';
import 'package:loto/page/shopping/recipe/model/recipe_form.dart';
import 'package:loto/page_config.dart';
import 'package:loto/widget/loading/loading_overlay.dart';

class RecipeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecipeController(), fenix: true);
  }
}

class RecipeController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final RxList<RecipeModel> listMain = <RecipeModel>[].obs;
  final RxList<RecipeModel> listSub = <RecipeModel>[].obs;

  final IngredientForm ingredientForm = IngredientForm();
  late RecipeForm recipeForm;

  final RxList<IngredientModel> listIngredient = <IngredientModel>[].obs;

  final RxInt indexSelect = (-1).obs;
  final RxBool isEmptyPage = false.obs;

  Future<void> streamGetRecipe() async {
    CollectionReference roomRef = firestore
        .collection(DataRowName.Cakes.name)
        .doc(DataCollection.Recipes.name)
        .collection("Cakes");

    var a = await roomRef.where("type", isEqualTo: 1).get();
    var list = a.docChanges
        .map<RecipeModel>(
            (e) => RecipeModel.fromJson(e.doc.data() as Map<String, dynamic>))
        .toList();
    listMain.addAll(list);
  }

  Future<void> streamGetRecipe2() async {
    CollectionReference roomRef = firestore
        .collection(DataRowName.Cakes.name)
        .doc(DataCollection.Recipes.name)
        .collection("Cakes");

    var a = await roomRef.where("type", isEqualTo: 2).get();
    var list = a.docChanges
        .map<RecipeModel>(
            (e) => RecipeModel.fromJson(e.doc.data() as Map<String, dynamic>))
        .toList();
    listSub.addAll(list);
  }

  RecipeModel covertData(Map<String, dynamic> data) {
    return RecipeModel.fromJson(data);
  }

  Future<void> onViewRecipeDetail(int index) async {
    var relatedList = listMain[index].relate ?? [];

    if (indexSelect.value != -1 && indexSelect.value == index) {
      for (var e in listSub) {
        e.isSelected.value = false;
      }
      indexSelect.value = -1;
      return;
    }

    if (indexSelect.value != index) {
      listMain[index].cakeIngredientSub.clear();
      if (relatedList.isNotEmpty) {
        for (var e in listSub) {
          e.isSelected.value = false;
          if (relatedList.contains(e.cakeID)) {
            e.isSelected.value = true;

            var cakeIng = CakeIngredient.setDefault(e.cakeName ?? '');
            listMain[index].cakeIngredientSub.add(cakeIng);
            e.cakeIngredient?.forEach((child) {
              child.quantity = (child.quantity ?? 0) / (e.unit ?? 0);
            });
            listMain[index].cakeIngredientSub.addAll(e.cakeIngredient ?? []);
          }
        }
      }
      indexSelect.value = index;
      await 1.delay();
      Get.toNamed(PageConfig.RECIPE_DETAIL, arguments: listMain[index]);
    }
  }

  @override
  void onInit() {
    initFirst();
    super.onInit();
  }

  Future<void> initFirst() async {
    var isPass = await checkPermissionAccess();
    isEmptyPage.value = !isPass;
    if (isPass) {
      await initMasterData();
      await streamGetRecipe();
      await streamGetRecipe2();
    }
  }

  Future<bool> checkPermissionAccess() async {
    final bool isAuthenticated = AppCommon.singleton.isLogin;

    if (!isAuthenticated) {
      await 0.5.delay();
      await Get.toNamed(PageConfig.LOGIN);
    }
    final currentUser = AppCommon.singleton.userLoginData;

    if (!(currentUser.isAdmin ?? false)) {
      Get.snackbar(
        'Thông báo',
        'Bạn không có quyền truy cập trang này',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    print(currentUser.isAdmin);
    return currentUser.isAdmin ?? false;
  }

  Future<void> initMasterData() async {
    try {
      if (AppCommon.singleton.listIngredientMaster.isNotEmpty) return;
      CollectionReference roomRef = firestore
          .collection(DataRowName.Cakes.name)
          .doc(DataCollection.Ingredients.name)
          .collection("1");
      var res = await roomRef.get();
      List<IngredientModel> list = [];
      for (var e in res.docChanges) {
        IngredientModel model =
            IngredientModel.fromJson(e.doc.data() as Map<String, dynamic>);
        list.add(model);
      }

      listIngredient.clear();
      list.sort((a, b) => -a.id!.compareTo(b.id!));
      listIngredient.addAll(list);
      AppCommon.singleton.listIngredientMaster.addAll(list);
    } catch (e) {
      e.printInfo(info: " loi init master data ");
    }
  }

  Future<void> showAddRecipeDialog(BuildContext context) async {
    recipeForm = RecipeForm(
      listModel: AppCommon.singleton.listIngredientMaster,
      listSub: listSub,
    );
    await Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: EditRecipeLayout(controller: this),
      ),
      barrierDismissible: false,
    );
    recipeForm.dispose();
  }

  void showAddIngredientDialog(BuildContext context) {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: EditIngredientLayout(controller: this),
    ));
  }

  Future<void> addNewIngredient(BuildContext context) async {
    int newID = (listIngredient.first.id ?? 0) + 1;
    ingredientForm.id = newID;

    LoadingOverlay.instance().show(context: context);
    var ref = firestore
        .collection(DataRowName.Cakes.name)
        .doc(DataCollection.Ingredients.name)
        .collection("1")
        .doc();
    print(ref.id);
    await firestore
        .collection(DataRowName.Cakes.name)
        .doc(DataCollection.Ingredients.name)
        .collection("1")
        .doc(ref.id)
        .set(ingredientForm.toJson());
    listIngredient.add(IngredientModel.fromOther(ingredientForm));
    AppCommon.singleton.listIngredientMaster
        .add(IngredientModel.fromOther(ingredientForm));
    LoadingOverlay.instance().hide();
    Get.back();
  }

  void updateStateByKey(String key) {
    update([key]);
  }

  void onAddIngredientForm() {
    var form = recipeForm.listIngredientPick.first;
    recipeForm.cakeIngredient.add(form);
    updateStateByKey('updateListIngredient');
  }

  void onRemoveIngredientForm(int i) {
    recipeForm.cakeIngredient.removeAt(i);
    updateStateByKey('updateListIngredient');
  }

  Future<void> addNewRecipe(BuildContext context) async {
    LoadingOverlay.instance().show(context: context);

    var filterList = [...listSub, ...listMain];
    filterList.sort((a, b) => (a.cakeID ?? 0).compareTo(b.cakeID ?? 0));
    int newID = filterList.last.cakeID ?? 0;
    recipeForm.cakeID = newID;

    if(recipeForm.recipeType.typeID == 2){
      recipeForm.relate = [];
    }else{
      recipeForm.relate = recipeForm.listSub.map<int>((e) => e.cakeID ?? 0).toList();
    }

    print(recipeForm.toJson());

    var ref = firestore
        .collection(DataRowName.Cakes.name)
        .doc(DataCollection.Recipes.name)
        .collection("Cakes")
        .doc();
    print(ref.id);
    await firestore
        .collection(DataRowName.Cakes.name)
        .doc(DataCollection.Recipes.name)
        .collection("Cakes")
        .doc(ref.id)
        .set(recipeForm.toJson());
    if(recipeForm.recipeType.typeID == 1){
      listMain.add(RecipeModel.fromJsonForm(recipeForm));
    }else{
      listSub.add(RecipeModel.fromJsonForm(recipeForm));
    }
    LoadingOverlay.instance().hide();
    Get.back();
  }

  void onAddRecipeSub() {
    var form = RecipeModel();
    form = recipeForm.listSubPick.first;
    recipeForm.listSub.add(form);
    updateStateByKey('updateListRecipeSub');
  }

  void onRemoveRecipeSubForm(int i) {
    recipeForm.listSub.removeAt(i);
    updateStateByKey('updateListRecipeSub');
  }

  Future<void> onRemoveRecipe(RecipeModel data) async {
    await firestore
        .collection(DataRowName.Cakes.name)
        .doc(DataCollection.Recipes.name)
        .collection("Cakes").doc(data.documentID).delete();

    if(data.type == 1){
      listMain.removeWhere((e) => e.cakeID == data.cakeID);
    }else{
      listSub.removeWhere((e) => e.cakeID == data.cakeID);
    }
    Get.snackbar(
      'Thông báo',
      'Bạn đã xóa thành công',
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
