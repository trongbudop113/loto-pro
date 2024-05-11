import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loto/common/mesage_util.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/profile/dialog/select_option_layout.dart';
import 'package:loto/page/profile/image_server/choose_image/choose_image_controller.dart';
import 'package:loto/page/profile/model/option_data.dart';
import 'package:loto/page/profile/page_manager/edit_page_manager/models/image_pick.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';
import 'package:loto/page_config.dart';

class ProductDetailManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailManagerController());
  }
}

class ProductDetailManagerController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final Rx<CakeProduct> cakeProduct = CakeProduct().obs;

  final ImagePicker _picker = ImagePicker();
  final Rx<ImagePick> imageUserPick = ImagePick().obs;

  final RxBool isModeAddNew = true.obs;
  final RxString appbarName = "".obs;

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productDiscountController =
      TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final List<int> listType = [150, 200, 250];
  final RxInt currentTypeCake = 150.obs;

  final RxList<ImagePick> listImagePick = <ImagePick>[].obs;

  final RxBool isShowLoadingView = false.obs;

  List<OptionData> listOption = [
    OptionData(value: "from_gallery", type: 1),
    OptionData(value: "from_server", type: 2)
  ];

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  initData() {
    var data = Get.arguments;

    if (data != null) {
      isModeAddNew.value = false;
      cakeProduct.value = data;
      descriptionController.text = cakeProduct.value.productDescription ?? '';
      productNameController.text = cakeProduct.value.productName ?? '';
      productPriceController.text = "${cakeProduct.value.productPrice ?? 0.0}";
      productDiscountController.text =
          "${cakeProduct.value.productDiscount ?? 0.0}";

      if ((cakeProduct.value.productImages ?? []).isNotEmpty) {
        imageUserPick.value.imagePath = cakeProduct.value.productImages!.first;
        imageUserPick.value.type = 1;

        var list = (cakeProduct.value.productImages ?? []).map<ImagePick>((e){
          return ImagePick(type: 1, imagePath: e);
        }).toList();

        listImagePick.addAll(list);
      }
      appbarName.value = cakeProduct.value.productName ?? '';
      currentTypeCake.value = cakeProduct.value.productType ?? listType.first;
      return;
    }

    appbarName.value = "Tạo mới";
    productNameController.text = '';
    productPriceController.text = "0";
    productDiscountController.text = "0";
  }

  Future<void> onSelectImageFromLocal() async {
    List<XFile>? imagePicks = await _picker.pickMultiImage(
      maxWidth: 300,
      maxHeight: 300,
      imageQuality: 100,
    );
    if (imagePicks.isEmpty) return;

    List<ImagePick> newList = [];
    for (var e in imagePicks) {
      ImagePick localImage = ImagePick();
      localImage.localPath = await e.readAsBytes();
      localImage.type = 2;
      newList.add(localImage);
    }

    listImagePick.addAll(newList);
  }

  Future<void> onCreateOrUpdateProduct() async {
    isShowLoadingView.value = true;
    try {
      if (productNameController.text == "" ||
          productPriceController.text == '') {
        MessageUtil.show(
          msg: "Điền đầy đủ thông tin",
          duration: 1,
        );
        isShowLoadingView.value = false;
        return;
      }

      for (var data in listImagePick) {
        if (data.type == 2) {
          await uploadFile(data);
        }
      }

      List<String> listImageFinal =
          listImagePick.map<String>((e) => e.imagePath ?? '').toList();

      // if (isModeAddNew.value) {
      //   await uploadFile(imageUserPick.value.localPath!);
      // } else {
      //   if (imageUserPick.value.type != 1 &&
      //       imageUserPick.value.imagePath != cakeProduct.value.productImage) {
      //     await uploadFile(imageUserPick.value.localPath!);
      //   }
      // }
      //
      // print("isUpdateImageSuccess $isUpdateImageSuccess");
      // if (!isUpdateImageSuccess) {
      //   return;
      // }

      cakeProduct.value.productImages = listImageFinal;
      if (productNameController.text != (cakeProduct.value.productName ?? '')) {
        cakeProduct.value.productName = productNameController.text;
      }

      if (productDiscountController.text !=
          (cakeProduct.value.productDiscount ?? '')) {
        cakeProduct.value.productDiscount =
            double.parse(productDiscountController.text);
      }

      if (productPriceController.text !=
          "${(cakeProduct.value.productPrice ?? 0)}") {
        cakeProduct.value.productPrice =
            double.parse(productPriceController.text);
      }

      if (isModeAddNew.value) {
        cakeProduct.value.createDate = DateTime.now();
      }
      cakeProduct.value.updateDate = DateTime.now();
      cakeProduct.value.productType = currentTypeCake.value;

      CollectionReference collectionRef =
          firestore.collection(DataRowName.Cakes.name);
      await collectionRef
          .doc(DataCollection.Products.name)
          .collection(DataCollection.MoonCakes.name)
          .doc(cakeProduct.value.productID)
          .update(cakeProduct.value.toJson());

      isShowLoadingView.value = false;
      MessageUtil.show(msg: "Cập nhật thành công");
      Get.back();

      // if(isModeAddNew.value){
      //   CollectionReference collectionRef = firestore.collection(DataRowName.Menus.name);
      //   await collectionRef.doc(idBlock).collection(idCollection)
      //       .doc(idDocumentChild).set(blockPage.value.toJson());
      // }else{
      //   CollectionReference collectionRef = firestore.collection(DataRowName.Menus.name);
      //   await collectionRef.doc(idBlock).collection(idCollection)
      //       .doc(idDocumentChild).update(blockPage.value.toJson());
      // }
    } catch (e, t) {
      print(e);
      print(t);
      isShowLoadingView.value = false;
      MessageUtil.show(msg: "Cập nhật không thành công");
    }
  }

  Future<void> uploadFile(ImagePick imagePick) async {
    print("uploadFile");
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference =
        FirebaseStorage.instance.ref().child("moon_cake/cakes/$fileName");
    UploadTask uploadTask = reference.putData(
        imagePick.localPath!,
        SettableMetadata(
          contentType: "image/jpeg",
        ));
    TaskSnapshot storageTaskSnapshot = uploadTask.snapshot;

    await uploadTask.then((event) async {
      print("${event.state}");
      if (event.state == TaskState.success) {
        print("uploadFile success");
        await storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
          print("uploadFile $downloadUrl");
          if (downloadUrl.isNotEmpty) {
            imagePick.imagePath = downloadUrl;
          }
        }, onError: (e) {
          MessageUtil.show(
            msg: "Upload hình lỗi",
            duration: 1,
          );
        });
      }
    });
  }

  Color getBackgroundColor(String? color, BuildContext context) {
    if (color == null) return Theme.of(context).backgroundColor;
    return Color(int.parse("0xFF$color"));
  }

  void onChangeTypeCake(int listType) {
    currentTypeCake.value = listType;
  }

  Future<void> onAddListImage(BuildContext context) async {
    var result = await onShowDialogAddImage(context);
    if (result == "from_gallery") {
      onSelectImageFromLocal();
    } else {
      onSelectImageFromServer();
    }
  }

  Future<String?> onShowDialogAddImage(BuildContext context) async {
    var result = await showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (builder) {
          return SelectOptionLayout(
            title: "Chọn Ảnh",
            listOption: listOption,
          );
        });
    return result;
  }

  Future<void> onSelectImageFromServer() async {
    // "moon_cake/cakes";
    var result = await Get.toNamed(
      PageConfig.CHOOSE_IMAGE,
      arguments: {"type": 2, "path": "moon_cake/cakes"},
    );
    if (result != null) {
      var object = jsonDecode(result);
      var listImage = (object['images'] as List).map<ImagePick>((e) {
        ImageServer data = ImageServer.fromJson(e);
        return ImagePick(imagePath: data.imagePathAfterParse, type: 1);
      }).toList();
      listImagePick.addAll(listImage);
    }
  }

  void onSelectCurrentImage(ImagePick data, int index) {
    imageUserPick.value = data;
    imageUserPick.value.selectIndexView = index;
  }

  void onDeleteCurrentImage(int index) {
    listImagePick.removeAt(index);
    if (imageUserPick.value.selectIndexView > 0 &&
        imageUserPick.value.selectIndexView == index) {
      imageUserPick.value = ImagePick();
    }
  }

  Future<void> onEditCurrentImage(BuildContext context) async {
    if (imageUserPick.value.selectIndexView == -1) return;
    var result = await onShowDialogAddImage(context);
    if (result == "from_gallery") {
      onChangeCurrentImageLocal(imageUserPick.value.selectIndexView);
    } else {
      onChangeCurrentImageServer(imageUserPick.value.selectIndexView);
    }
  }

  Future<void> onChangeCurrentImageLocal(int index) async {
    XFile? imagePick = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
      imageQuality: 100,
    );
    if (imagePick == null) return;

    ImagePick localImage = ImagePick();
    localImage.localPath = await imagePick.readAsBytes();
    localImage.type = 2;
    imageUserPick.value = localImage;

    listImagePick[index] = imageUserPick.value;
  }

  Future<void> onChangeCurrentImageServer(int index) async {
    var result = await Get.toNamed(
      PageConfig.CHOOSE_IMAGE,
      arguments: {"type": 1, "path": "moon_cake/cakes"},
    );
    if (result != null) {
      var object = jsonDecode(result);
      var listImage = (object['images'] as List).map<ImagePick>((e) {
        ImageServer data = ImageServer.fromJson(e);
        return ImagePick(imagePath: data.imagePathAfterParse, type: 1);
      }).toList();
      listImagePick[index] = listImage.first;
    }
  }

  void onChangShowHideProduct(bool value) {
    cakeProduct.value.isShow = value;
    cakeProduct.refresh();
  }
}
