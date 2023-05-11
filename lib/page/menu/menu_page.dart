import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/menu/menu_controller.dart';
import 'package:loto/page/resources/image_resource.dart';

class MenuPage extends GetView<MenuController>{
  MenuPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildContent(),
    );
  }

  Widget buildContent(){
    return Container(
      margin: EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: controller.listMenu.length,
        itemBuilder: (ctx, index){
          return InkWell(
            onTap: (){
              controller.goToRoomPage(controller.listMenu[index]);
            },
            child: Container(
              color: Colors.transparent,
              child: Column(
                children: [
                  Container(
                    color: Colors.transparent,
                    child: Image.asset(ImageResource.ic_app_loto),
                  ),
                  Text(controller.listMenu[index].name ?? '', style: TextStyle(fontSize: 18))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}