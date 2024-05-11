import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/profile/product_manager/product_manager/product_manager_controller.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';

class ProductManagerPage extends GetView<ProductManagerController> {
  const ProductManagerPage({super.key});

  @override
  Widget build(BuildContext context) {

    final double heightItem = (MediaQuery.of(context).size.width * .3) > 250 ? 250 : (MediaQuery.of(context).size.width * .3);

    return Scaffold(
      appBar: AppBar(
        title: Text("product_management".tr),
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
          GestureDetector(
            onTap: (){
              controller.onAddNewProduct();
            },
            child: Container(
              width: 55,
              color: Colors.transparent,
              child: Icon(Icons.add,),
            ),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamGetProduct(),
        builder: (c, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (c, i){

                CakeProduct cake = CakeProduct.fromJson(snapshot.data!.docs[i].data() as Map<String, dynamic>);

                if(cake.productType == 200){
                  return GestureDetector(
                    onTap: (){
                      controller.onTapItem(cake);
                    },
                    child: Container(
                      height: heightItem,
                      color: Colors.grey,
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              alignment: Alignment.center,
                              color: controller.getBackgroundColor(cake.productColor, context),
                              child: Image.network(cake.productImageMain),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10,),
                              Text(cake.productName ?? ''),
                              const SizedBox(height: 10,),
                              Text("Loại: ${cake.productType ?? 0}g")
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }
                return GestureDetector(
                  onTap: (){
                    controller.onTapItem(cake);
                  },
                  child: Container(
                    height: heightItem,
                    color: Colors.grey,
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 10,),
                            Text(cake.productName ?? ''),
                            const SizedBox(height: 10,),
                            Text("Loại: ${cake.productType ?? 0}g")
                          ],
                        ),
                        const SizedBox(width: 10,),
                        AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            alignment: Alignment.center,
                            color: controller.getBackgroundColor(cake.productColor, context),
                            child: Image.network(cake.productImageMain),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}