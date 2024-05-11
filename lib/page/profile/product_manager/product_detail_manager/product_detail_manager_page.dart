import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/profile/page_manager/edit_page_manager/models/image_pick.dart';
import 'package:loto/page/profile/product_manager/product_detail_manager/product_detail_manager_controller.dart';
import 'package:loto/src/color_resource.dart';
import 'package:loto/src/style_resource.dart';

class ProductDetailManagerPage extends GetView<ProductDetailManagerController> {
  const ProductDetailManagerPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
          controller.appbarName.value
        )),
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Container(
            color: Colors.transparent,
            child: Icon(Icons.arrow_back),
          ),
        ),
        actions: [
          Obx(() => Visibility(
            visible: !controller.isModeAddNew.value,
            child: GestureDetector(
              onTap: (){
                //controller.deleteDocument();
              },
              child: Container(
                width: 55,
                color: Colors.transparent,
                child: Icon(Icons.delete, color: Colors.red,),
              ),
            ),
          ))
        ],
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              _buildBlockImage(context),
              const SizedBox(height: 15,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Obx(() => Column(
                  children: [
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Text(
                          "Màu:",
                          style: TextStyleResource.textStyleBlack(context),
                        ),
                        SizedBox(width: 15,),
                        Container(
                          width: 100,
                          height: 35,
                          color: controller.getBackgroundColor(controller.cakeProduct.value.productColor, context),
                        )
                      ],
                    ),
                    SizedBox(height: 15,),
                    Container(
                      height: 50,
                      child: TextField(
                        controller: controller.productNameController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            labelText: "Tên sản phẩm",
                            labelStyle: TextStyle(
                                height: 1.5
                            ),
                            contentPadding: EdgeInsets.only(top: 10)
                        ),
                        onChanged: (text) {

                        },
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextField(
                      controller: controller.productPriceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: "Giá sản phẩm",
                          labelStyle: TextStyle(
                              height: 1.5
                          ),
                          contentPadding: EdgeInsets.only(top: 10)
                      ),
                      onChanged: (text) {

                      },
                    ),
                    SizedBox(height: 15,),
                    TextField(
                      controller: controller.productDiscountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: "Giảm giá",
                          labelStyle: TextStyle(
                              height: 1.5
                          ),
                          contentPadding: EdgeInsets.only(top: 10)
                      ),
                      onChanged: (text) {

                      },
                    ),
                    SizedBox(height: 15,),
                    _buildNote(context),
                    SizedBox(height: 15,),
                    Container(
                      height: 40,
                      child: Row(
                        children: [
                          Text(
                            "Loại:",
                            style: TextStyleResource.textStyleBlack(context),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: ListView.separated(
                              itemCount: controller.listType.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (c, i){
                                return GestureDetector(
                                  onTap: (){
                                    controller.onChangeTypeCake(controller.listType[i]);
                                  },
                                  child: Obx((){
                                    return Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: controller.listType[i] == controller.currentTypeCake.value? Colors.black : Colors.transparent,
                                          width: 2,
                                        ),
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(horizontal: 15,),
                                      child: Text("${controller.listType[i]}g"),
                                    );
                                  }),
                                );
                              },
                              separatorBuilder: (c, i){
                                return SizedBox(width: 10);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Text(
                          "Hiện trên danh sách:",
                          style: TextStyleResource.textStyleBlack(context),
                        ),
                        SizedBox(width: 10,),
                        Switch(
                          value: controller.cakeProduct.value.isShow ?? false,
                          onChanged: (value){
                            controller.onChangShowHideProduct(value);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Cập nhật gần nhất: ${controller.cakeProduct.value.updateDate}",
                        style: TextStyleResource.textStyleBlack(context),
                      ),
                    )
                  ],
                )),
              )
            ],
          ),
          Positioned.fill(
            child: Obx(() => Visibility(
              visible: controller.isShowLoadingView.value,
              child: Container(
                color: Colors.black45,
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: ColorResource.color_background_light,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ),
                ),
              ),
            )),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: GestureDetector(
          onTap: (){
            controller.onCreateOrUpdateProduct();
          },
          child: Container(
            height: 55,
            decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(60,)
            ),
            alignment: Alignment.center,
            child: Obx(() => Text(controller.isModeAddNew.value ? "Tạo mới" : "Cập nhật")),
          ),
        ),
      ),
    );
  }

  Widget _buildBlockImage(BuildContext context){

    final double width = MediaQuery.of(context).size.width;
    if(context.isLargeTablet){
      return Row(
        children: [
          _imageMain(context, width: width),
          const SizedBox(width: 10,),
          _buildListImage(context, width: width),
        ],
      );
    }

    return Column(
      children: [
        _imageMain(context, width: width),
        const SizedBox(height: 10,),
        _buildListImage(context, width: width),
      ],
    );
  }

  Widget _imageMain(BuildContext context, {required double width}){
    return Stack(
      children: [
        _loadBlockIcon(context, width: width),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: (){
              controller.onEditCurrentImage(context);
            },
            child: Container(
              width: 50,
              height: 50,
              color: Colors.black45,
              child: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildNote(BuildContext context){
    return TextFormField(
      minLines: 6,
      maxLines: null,
      controller: controller.descriptionController,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        alignLabelWithHint: true,
        border: OutlineInputBorder(),
        labelText: 'Thành phần',
      ),
    );
  }

  Widget _buildListImage(BuildContext context, {required double width}){
    final double maxWidthImage = width * 0.4 > 1000 ? 1000 : (width * 0.4);
    final double height = context.isLargeTablet ? maxWidthImage : ((width - 20) / 5);
    final double widthList = context.isLargeTablet ? ((height - 20) / 5) : width;
    final Axis direction = context.isLargeTablet ? Axis.vertical : Axis.horizontal;
    final double? heightItem = context.isLargeTablet ? ((height - 20) / 5) : null;
    final double mgRight = context.isLargeTablet ? 0 : 5;
    final double mgBottom = context.isLargeTablet ? 5 : 0;


    return Container(
        margin: const EdgeInsets.only(top: 5),
        height: height,
        width: widthList,
        child: Obx((){
          return ListView.separated(
            itemCount: controller.listImagePick.length + 1,
            scrollDirection: direction,
            itemBuilder: (c, i){
              if((controller.listImagePick.length) == i){
                return GestureDetector(
                  onTap: (){
                    controller.onAddListImage(context);
                  },
                  child: Container(
                    width: height,
                    height: heightItem,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.grey.withOpacity(.5),
                    ),
                    child: const Icon(Icons.add),
                  ),
                );
              }
              return GestureDetector(
                onTap: (){
                  controller.onSelectCurrentImage(controller.listImagePick[i], i);
                },
                child: Stack(
                  children: [
                    Container(
                      //height: height,
                      width: heightItem,
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey,
                      ),
                      child: _getImage(controller.listImagePick[i]),
                    ),

                    Positioned(
                      top: 0,
                      left: 0,
                      child: GestureDetector(
                        onTap: (){
                          controller.onDeleteCurrentImage(i);
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          padding: EdgeInsets.all(8),
                          color: Colors.transparent,
                          child: const Icon(Icons.remove_circle, color: Colors.red,),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (c, i){
              return SizedBox(width: mgRight, height: mgBottom,);
            },
          );
        }),
    );
  }

  Image _getImage(ImagePick imagePick){
    if(imagePick.type == 1){
      return Image.network(imagePick.imagePath ?? '');
    }else{
      return Image.memory(imagePick.localPath!);
    }
  }

  Widget _loadBlockIcon(BuildContext context, {required double width}){

    double maxWidthImage = MediaQuery.of(context).size.width;
    if(context.isLargeTablet){
      maxWidthImage = width * 0.4 > 1000 ? 1000 : (width * 0.4);
    }


    return SizedBox(
      width: maxWidthImage,
      height: maxWidthImage,
      child: Obx((){
        if(controller.imageUserPick.value.type == null){
          return Container(
            color: Colors.grey,
          );
        }
        if(controller.imageUserPick.value.type == 1){
          return Image.network(controller.imageUserPick.value.imagePath ?? '');
        }else{
          return Image.memory(controller.imageUserPick.value.localPath!);
        }
      }),
    );
  }
}