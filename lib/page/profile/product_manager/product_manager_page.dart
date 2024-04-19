import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/profile/product_manager/product_manager_controller.dart';
import 'package:loto/page/shopping/moon_cake/models/cake_product.dart';

class ProductManagerPage extends GetView<ProductManagerController> {
  const ProductManagerPage({super.key});

  @override
  Widget build(BuildContext context) {

    final double heightItem = (MediaQuery.of(context).size.width * .3) > 250 ? 250 : (MediaQuery.of(context).size.width * .3);

    return Scaffold(
      appBar: AppBar(
        title: Text("product_management".tr),
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
                              color: Colors.amber,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            children: [
                              Text("${cake.productName ?? ''}")
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
                            Text("${cake.productName ?? ''}")
                          ],
                        ),
                        SizedBox(width: 10,),
                        AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.amber,
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