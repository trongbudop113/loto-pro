import 'dart:convert';
import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
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
import 'package:loto/src/color_resource.dart';

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
  final RxString mainColor = Colors.grey.hex.obs;

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
      mainColor.value = cakeProduct.value.productColor ?? '';
      // print(cakeProduct.value.productColor);
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

  List<String> get listImagePickAfter {
    if(listImagePick.isEmpty) return [];
    return listImagePick.map<String>((e) => (e.imageName ?? '')).toList();
  }

  List<String> get listImagePickBefore {
    if((cakeProduct.value.productImages ?? []).isEmpty) return [];
    return cakeProduct.value.productImages!;
  }

  bool get compareTwoListImage{
    listImagePickBefore.sort((a, b) => a.compareTo(b));
    listImagePickAfter.sort((a, b) => a.compareTo(b));
    return const Equality().equals(listImagePickBefore, listImagePickAfter);
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

      List<String> listImageFinal = [];
      if(compareTwoListImage == false){
        for (var data in listImagePick) {
          if (data.type == 2) {
            await uploadFile(data);
          }
        }

        listImageFinal = listImagePick.map<String>((e) => e.imagePath ?? '').toList();
      }

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

      if(listImageFinal.isNotEmpty){
        cakeProduct.value.productImages = listImageFinal;
      }
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
      if(cakeProduct.value.productColor != mainColor.value){
        cakeProduct.value.productColor = mainColor.value;
      }

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
    if (color == null) return ColorResource.color_background_light;
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

  Future<void> onPickerColor(BuildContext context) async {
    colorPickerDialog(context);
  }

  Future<bool> colorPickerDialog(BuildContext context) async {
    return ColorPicker(
      color: Color(int.parse("0xFF${mainColor.value}")),
      onColorChanged: (Color color) {
        mainColor.value = color.hex;
      },
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodyMedium,
      colorCodePrefixStyle: Theme.of(context).textTheme.bodySmall,
      selectedPickerTypeColor: Theme.of(context).colorScheme.primary,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
      customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      actionsPadding: const EdgeInsets.all(16),
      constraints:
      const BoxConstraints(minHeight: 480, minWidth: 300, maxWidth: 320),
    );
  }

  static const Color guidePrimary = Color(0xFF6200EE);
  static const Color guidePrimaryVariant = Color(0xFF3700B3);
  static const Color guideSecondary = Color(0xFF03DAC6);
  static const Color guideSecondaryVariant = Color(0xFF018786);
  static const Color guideError = Color(0xFFB00020);
  static const Color guideErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);

  final Map<ColorSwatch<Object>, String> colorsNameMap =
  <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(guidePrimary): 'Guide Purple',
    ColorTools.createPrimarySwatch(guidePrimaryVariant): 'Guide Purple Variant',
    ColorTools.createAccentSwatch(guideSecondary): 'Guide Teal',
    ColorTools.createAccentSwatch(guideSecondaryVariant): 'Guide Teal Variant',
    ColorTools.createPrimarySwatch(guideError): 'Guide Error',
    ColorTools.createPrimarySwatch(guideErrorDark): 'Guide Error Dark',
    ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
  };
}
