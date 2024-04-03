import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/profile/profile_manager/profile_manager_controller.dart';
import 'package:loto/src/style_resource.dart';

class ProfileManagerPage extends GetView<ProfileManagerController> {
  const ProfileManagerPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                _loadBlockIcon(),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: (){
                      controller.onChangeAvatar();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.black45,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Kích thước 128 x 128",
                style: TextStyleResource.textStyleBlack(context),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  Container(
                    height: 50,
                    child: TextField(
                      controller: controller.blockNameController,
                      decoration: const InputDecoration(
                          labelText: "Tên người dùng",
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
                    controller: controller.blockPhoneController,
                    decoration: const InputDecoration(
                        labelText: "Số điện thoại",
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
                    controller: controller.blockAddressController,
                    decoration: const InputDecoration(
                        labelText: "Địa chỉ",
                        labelStyle: TextStyle(
                            height: 1.5
                        ),
                        contentPadding: EdgeInsets.only(top: 10)
                    ),
                    onChanged: (text) {

                    },
                  ),
                  SizedBox(height: 15,),
                  Obx(() => Row(
                    children: [
                      Text(
                        "Đăng nhập gần đây: ",
                        style: TextStyleResource.textStyleBlack(context),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        controller.currentUserLogin.value.loginDate,
                        style: TextStyleResource.textStyleBlack(context),
                      ),
                    ],
                  )),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: GestureDetector(
          onTap: (){
            controller.onUpdateUserInfo();
          },
          child: Container(
            height: 55,
            decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(60,)
            ),
            alignment: Alignment.center,
            child: Text("Cập nhật"),
          ),
        ),
      ),
    );
  }

  Widget _loadBlockIcon(){
    return AspectRatio(
      aspectRatio: 1,
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