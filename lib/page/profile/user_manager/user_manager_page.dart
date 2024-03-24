import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/profile/user_manager/user_manager_controller.dart';
import 'package:loto/src/style_resource.dart';

class UserManagerPage extends GetView<UserManagerController> {
  const UserManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("user_management".tr),
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

            child: Container(
              width: 55,
              color: Colors.transparent,
              child: Icon(Icons.add,),
            ),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.getAllUser(),
        builder: (c, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.separated(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (c, i) {
              UserLogin userInfo = UserLogin.fromJson(
                  snapshot.data!.docs[i].data() as Map<String, dynamic>);
              return Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(360),
                      child: Container(
                        width: 60,
                        height: 60,
                        color: Colors.black45,
                        alignment: Alignment.center,
                        child: Visibility(
                          visible: (userInfo.avatar ?? '').isNotEmpty,
                          child: Image.network(userInfo.avatar ?? ''),
                          replacement: Text(
                            (userInfo.name ?? "U")
                                .substring(0, 1)
                                .toUpperCase(),
                            style: TextStyleResource.textStyleBlack(context),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      userInfo.name ?? '',
                      style: TextStyleResource.textStyleBlack(context),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (c, i) {
              return Divider();
            },
          );
        },
      ),
    );
  }
}
